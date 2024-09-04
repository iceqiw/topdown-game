extends Area2D

class_name PickItemGui

@export var item:InventoryItem
@export var inv:Inventory
@onready var sprite_2d: Sprite2D = $Sprite2D


func _ready() -> void:
	sprite_2d.texture=item.texture

func collect():
	inv.insert(item)
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		collect()
