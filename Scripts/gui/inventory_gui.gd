class_name PlayerInv

extends Control
@onready var grid_container: GridContainer = $NinePatchRect/GridContainer

signal update_ui_event

var is_open: bool = false
## List of [SlotUI] representing each [Inventory] slot
var slots : Array[SlotGui]

@export var inventory : Inventory
@export var slot_ui_scene : PackedScene

func _ready() -> void:
	visible = true
	update_ui_event.connect(update_ui)
	update_ui()

	
func update_ui():
	for slot in slots:
		slot.queue_free()
		
	slots.clear()
	for slot in inventory.slots:
		var slot_obj:SlotGui = slot_ui_scene.instantiate()
		grid_container.add_child(slot_obj)
		slots.append(slot_obj)
		slot_obj.gui_input.connect(_on_slot_gui_input.bind(slot_obj))
		if slot.amount!=0:
			slot_obj.update_info_with_slot(slot)

func _on_slot_gui_input(event : InputEvent, slot_obj):
	if event is InputEventMouseButton :
		if event.pressed:	
			var index = slots.find(slot_obj)
			if index < 0:
				return 
