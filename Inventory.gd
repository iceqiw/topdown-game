extends Resource

class_name Inventory

@export var items:Array[InventoryThings]
signal update_item

func  insert(item:InventoryThings):
	items.append(item)
	update_item.emit()
