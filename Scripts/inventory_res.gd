extends Resource

class_name Inventory

@export var stacks:Array[InventoryStack]

signal update_item

func  insert(item:InventoryItem):
	var itemStacks=stacks.filter(func(stack): return stack.item==item)
	if !itemStacks.is_empty():
		itemStacks[0].amount +=1
	else:
		var emptyStacks=stacks.filter(func(stack): return stack.item==null)
		if !emptyStacks.is_empty():
			emptyStacks[0].item=item
			emptyStacks[0].amount=1
	update_item.emit()
			
