extends CharacterBody2D

class_name Enemy

var player: Player

var health = 100

@export var SPEED = 40.0
var move = Vector2.ZERO
var player_inattack_zone = false
var damaged_cooldown = true

signal hp_change(hp)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hp_change.connect(_deal_on_damage)
	
func _physics_process(delta: float) -> void:
	if player != null:
		move = position.direction_to(player.position) * SPEED * delta
		move_and_collide(move)

func enemy():
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
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

func _deal_on_damage(dd):
	if damaged_cooldown:
		health = health - dd
		print(health)
		damaged_cooldown = false
			
	if health <= 0:
		self.queue_free()


func _on_damage_timer_timeout() -> void:
	damaged_cooldown = true
