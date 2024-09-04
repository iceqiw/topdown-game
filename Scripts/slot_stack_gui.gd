extends Panel

class_name SlotStackGui

@onready var dg: Sprite2D = $item
@onready var label: Label = $Label

var _inventoryStack: InventoryStack 

func update(stack:InventoryStack) :
	_inventoryStack = stack
	update_gui()

func update_gui() :
	if !_inventoryStack:
		label.visible =false
		dg.visible = false
	else :
		label.visible = true
		dg.visible = true
		dg.texture = _inventoryStack.item.texture
		label.text=str(_inventoryStack.amount)
