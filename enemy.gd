extends CharacterBody2D

var player: CharacterBody2D = null

@export var SPEED = 40.0
var move = Vector2.ZERO


func _physics_process(delta: float) -> void:
	if player != null:
		move = position.direction_to(player.position) * SPEED * delta
		move_and_collide(move)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "hero":
		player = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "hero":
		player = null
		move = Vector2.ZERO