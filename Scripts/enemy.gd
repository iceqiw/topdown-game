extends CharacterBody2D

class_name Enemy

@onready var ap: AnimationPlayer = $AnimationPlayer
@onready var effect: AnimationPlayer = $Effect

@export var damage:int = 10
@export var SPEED = 400.0

var damaged_cooldown = true
var player: Player
var health = 100

signal hp_change(hp)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hp_change.connect(_deal_on_damage)
	$hpbar.value=health
	ap.play("idle")
	
func _physics_process(delta: float) -> void:
	if player != null:
		var move = position.direction_to(player.position)
		velocity=move * delta * SPEED
		move_and_slide()


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

func _deal_on_damage(hp):
	if damaged_cooldown and health>=0 :
		health = health - hp
		print("enemy HP is: ",health)
		effect.play("damaged")
		$hpbar.value=health
		damaged_cooldown = false
	if health <= 0:
		self.queue_free()

func attack():
	if null != player:
		player.emit_signal("take_damage",damage)

func _on_damage_timer_timeout() -> void:
	if null != player:
		damaged_cooldown = true
		attack()
	if player.health <=0:
		$damaged_timer.stop()
