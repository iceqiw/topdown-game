class_name PlayerInv

extends Control

signal opened

signal closed

@export var inventory: Inventory

var is_open: bool = false

@onready var slots: Array = $NinePatchRect/GridContainer.get_children()



func _ready() -> void:
	visible = true
	update_ui()
	inventory.update_inv_gui.connect(update_ui)


func open():
	is_open = true
	visible = true
	opened.emit()


func close():
	is_open = false
	visible = false
	closed.emit()


func update_ui():
	for i in range(min(inventory.stacks.size(), slots.size())):
		var stack: InventoryStack = inventory.stacks[i]
		if !stack.item:
			continue
		slots[i].update(stack)
