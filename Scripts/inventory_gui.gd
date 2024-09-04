extends Control

class_name PlayerInv

@export var inventory:Inventory 
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var ssgclass= preload("res://gui/stack.tscn")
signal opened

signal closed


func _ready() -> void:
	visible=true
	update_item()
	inventory.update_item.connect(update_item)
	connectClickSlot()

var is_open:bool=false

func open():
	is_open=true
	visible=true
	opened.emit()
	
func close():
	is_open=false
	visible=false
	closed.emit()

func update_item():
	for i in range(min(inventory.stacks.size(),slots.size())):
		var stack:InventoryStack = inventory.stacks[i]
		if !stack.item: continue
		var slotStackGui:SlotStackGui =slots[i]._ssg
		if !slotStackGui:
			slotStackGui=ssgclass.instantiate()
			slots[i].insert(slotStackGui)
			
		slotStackGui.update(stack)
		
func connectClickSlot(): 
	for slot in slots:
		var callable=Callable(onClickSlot)
		callable=callable.bind(slot)
		slot.pressed.connect(callable)

func onClickSlot():
	pass
