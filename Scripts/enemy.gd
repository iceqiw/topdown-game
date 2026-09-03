extends CharacterBody2D

class_name Enemy

enum State { IDLE, CHASE, ATTACK, DEAD }

@export var speed: float = 400.0
@export var damage: int = 10
@export var max_health: int = 100

@onready var ap: AnimationPlayer = $AnimationPlayer
@onready var effect: AnimationPlayer = $Effect

var state: State = State.IDLE
var player: Player
var health: int = max_health
var damaged_cooldown: bool = true

signal hp_change(hp: int)


func _ready() -> void:
	health = max_health
	hp_change.connect(_deal_on_damage)
	$hpbar.max_value = max_health
	$hpbar.value = health
	ap.play("idle")


func _physics_process(delta: float) -> void:
	if state == State.DEAD:
		return

	if _player_valid():
		var move := position.direction_to(player.position)
		velocity = move * speed * delta
		move_and_slide()
	else:
		velocity = Vector2.ZERO


func _player_valid() -> bool:
	return player != null and is_instance_valid(player) and player.health > 0


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		player = null


func _on_e_hitbox_body_entered(body: Node2D) -> void:
	if body is Player:
		$damaged_timer.start()


func _on_e_hitbox_body_exited(body: Node2D) -> void:
	if body is Player:
		$damaged_timer.stop()


func _deal_on_damage(hp: int) -> void:
	if state == State.DEAD or not damaged_cooldown:
		return

	health -= hp
	health = clampi(health, 0, max_health)
	print("enemy HP is: ", health)
	effect.play("damaged")
	$hpbar.value = health
	damaged_cooldown = false

	if health <= 0:
		state = State.DEAD
		player = null
		queue_free()


func attack() -> void:
	if _player_valid():
		player.emit_signal("take_damage", damage)


func _on_damage_timer_timeout() -> void:
	damaged_cooldown = true
	if _player_valid():
		attack()
	else:
		$damaged_timer.stop()
