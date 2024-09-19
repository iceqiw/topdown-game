class_name InvItemGui

extends Area2D

@export var item: Item
@onready var sprite_2d: Sprite2D = $Sprite2D


func _ready() -> void:
	sprite_2d.texture = item.definition.icon

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.add_item_inv.emit(item)
		queue_free()
	
