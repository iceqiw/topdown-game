class_name PlayerInv

extends Control

@onready var slots_container: GridContainer = $NinePatchRect/GridContainer

@export var inventory : Inventory

@export var inventory_handler : InventoryHandler

@export var slot_ui_scene : PackedScene

@onready var transaction_slot_ui : TransactionSlotUI = $TransactionSlotUI


var is_open: bool = false
## List of [SlotUI] representing each [Inventory] slot
var slots : Array[SlotGui]


func _ready() -> void:
	visible = true
	inventory.updated_slot.connect(_on_updated_slot)
	inventory.slot_added.connect(_on_slot_added)
	inventory.slot_removed.connect(_on_slot_removed)
	update_ui()

	
func update_ui():
	for slot in slots:
		slot.queue_free()
		
	slots.clear()
	for slot in inventory.slots:
		var slot_obj:SlotGui = slot_ui_scene.instantiate()
		slots_container.add_child(slot_obj)
		slots.append(slot_obj)
		slot_obj.gui_input.connect(_on_slot_gui_input.bind(slot_obj))
		slot_obj.update_info_with_slot(slot)


func _on_slot_gui_input(event : InputEvent, slot_obj):
	if event is InputEventMouseButton :
		if event.pressed:	
			var index = slots.find(slot_obj)
			if index < 0:
				return
			_slot_point_down(index)
			
func _slot_point_down(slot_index : int):
	if inventory_handler.is_transaction_active():
		inventory_handler.transaction_to_at(slot_index, inventory, 1)
	else:
		if inventory.is_empty_slot(slot_index):
			return
		inventory_handler.to_transaction(slot_index, inventory, 1)
		print(inventory_handler.is_transaction_active())


func _on_inventory_handler_updated_transaction_slot() -> void:
	transaction_slot_ui.update_info_with_item(inventory_handler.transaction_slot)

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
