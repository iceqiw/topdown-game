extends Area2D

class_name PickItem

@export var item:InventoryThings
@export var inv:Inventory

func collect():
	inv.insert(item)
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		collect()
