class_name InventoryUI
extends Control


## Emitted when a [SlotUI] is clicked
signal slot_point_down(event : InputEvent, slot_index : int, inventory : Inventory)

@onready var slots_container: HBoxContainer = $VBoxContainer

@export var inventory : Inventory

@export var slot_ui_scene : PackedScene


var is_open: bool = false
## List of [SlotUI] representing each [Inventory] slot
var slots : Array[SlotGui]


func _ready() -> void:
	visible = true

	
func set_inventory(inv : Inventory):
	if inv != self.inventory:
		self.inventory = inv
		_connect_new_inventory(inv)


func _connect_new_inventory(inv : Inventory):
	inv.updated_slot.connect(_on_updated_slot)
	inv.slot_added.connect(_on_slot_added)
	inv.slot_removed.connect(_on_slot_removed)
	update_ui()
	
func update_ui():
	for slot in slots:
		slot.queue_free()
		
	slots.clear()
	for slot in inventory.slots:
		var slot_obj = slot_ui_scene.instantiate()
		slot_obj.gui_input.connect(_on_slot_gui_input.bind(slot_obj))
		slots_container.add_child(slot_obj)
		slots.append(slot_obj)
		slot_obj.update_info_with_slot(slot)


func _on_slot_gui_input(event : InputEvent, slot_obj):
	if event is InputEventMouseButton :
		if event.pressed:	
			var index = slots.find(slot_obj)
			if index < 0:
				return
			slot_point_down.emit(event, index, inventory)
			

			
func _on_updated_slot(index):
	slots[index].update_info_with_slot(inventory.slots[index])


func _on_slot_added(index):
	var slot_obj = slot_ui_scene.instantiate()
	slots_container.add_child(slot_obj)
	slots.insert(index, slot_obj)
	slot_obj.gui_input.connect(_on_slot_gui_input.bind(slot_obj))


			
func _on_slot_removed(index):
	slots[index].queue_free()
	slots.remove_at(index)
