class_name Inventory

extends Resource

signal update_inv_gui

@export var stacks: Array[InventoryStack]


func insert(item: InventoryItem):
	var item_stacks = stacks.filter(func(stack): return stack.item == item)
	if !item_stacks.is_empty():
		item_stacks[0].amount += 1
	else:
		var empty_stacks = stacks.filter(func(stack): return stack.item == null)
		if !empty_stacks.is_empty():
			empty_stacks[0].item = item
			empty_stacks[0].amount = 1
	update_inv_gui.emit()
