extends Control

class_name PlayerInv

@export var inventory:Inventory 
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

signal opened

signal closed


func _ready() -> void:
	visible=false
	update()
	inventory.update_item.connect(update)

var is_open:bool=false

func open():
	is_open=true
	visible=true
	opened.emit()
	
func close():
	is_open=false
	visible=false
	closed.emit()

func update():
	for i in range(min(inventory.items.size(),slots.size())):
		print(inventory.items.size())
		slots[i].update(inventory.items[i])
		
		
