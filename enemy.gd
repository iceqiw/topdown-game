extends CharacterBody2D

var player: CharacterBody2D = null

var health = 100

@export var SPEED = 40.0
var move = Vector2.ZERO
var player_inattack_zone = false
var damaged_cooldown = true
func _physics_process(delta: float) -> void:
	if player != null:
		move = position.direction_to(player.position) * SPEED * delta
		move_and_collide(move)
		deal_on_damage()

func enemy():
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "hero":
		player = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "hero":
		player = null
		move = Vector2.ZERO

func _on_e_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_inattack_zone = true
		$damaged_timer.start()


func _on_e_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_inattack_zone = false
		$damaged_timer.stop()

func deal_on_damage():
	if player_inattack_zone and gs.player_current_damage:
		if damaged_cooldown:
			health = health - 20
			print(health)
			damaged_cooldown = false
			
	if health <= 0:
		self.queue_free()


func _on_damage_timer_timeout() -> void:
	damaged_cooldown = true
