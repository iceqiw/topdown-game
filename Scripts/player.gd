class_name Player extends CharacterBody2D

enum State { IDLE, MOVE, ATTACK, HURT, DEAD }

@export var speed: float = 5000.0
@export var max_health: int = 100
@export var attack_damage: int = 20
@export var knockback_force: float = 500.0
@export var hurt_duration: float = 0.2

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var control: StatusBar = $panel/Control
@onready var effect: AnimationPlayer = $Effect
@onready var inventory_handler: InventoryHandler = $panel/NodeInventories/InventoryHandler
@onready var inventory_sys: InventorySystemUI = $panel/InventoryGui

var main_inv: Inventory
var state: State = State.IDLE
var input_direction: Vector2 = Vector2.ZERO
var player_direction: Vector2 = Vector2.LEFT
var enemy: Enemy
var health: int = max_health
var hurt_timer: float = 0.0

# Compatibility flags for the AnimationTree state machine
var is_attacking: bool = false
var is_idle: bool = true
var is_moving: bool = false
var is_dead: bool = false

signal take_damage(hp: int)
signal add_item_inv(item: Item)


func _ready() -> void:
	health = max_health
	take_damage.connect(_deal_on_damage)
	add_item_inv.connect(_on_add_item_inv)
	main_inv = inventory_handler.get_inventory(0)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and gs.not_dialogue:
		gs.dialogue()


func _physics_process(delta: float) -> void:
	_update_hurt(delta)
	_handle_attack_input()
	_update_movement(delta)
	_sync_animation_flags()
	_apply_animations()
	move_and_slide()


func _update_hurt(delta: float) -> void:
	if state == State.HURT:
		hurt_timer -= delta
		if hurt_timer <= 0.0:
			state = State.IDLE


func _sync_animation_flags() -> void:
	is_attacking = state == State.ATTACK
	is_idle = state == State.IDLE
	is_moving = state == State.MOVE
	is_dead = state == State.DEAD


func _handle_attack_input() -> void:
	if state == State.DEAD or state == State.HURT:
		return
	if Input.is_action_pressed("attack"):
		state = State.ATTACK
		_perform_attack()
	elif Input.is_action_just_released("attack"):
		state = State.IDLE


func _update_movement(delta: float) -> void:
	if state == State.DEAD or state == State.HURT or state == State.ATTACK:
		velocity = Vector2.ZERO
		return

	input_direction = Input.get_vector("left", "right", "up", "down")
	if input_direction == Vector2.ZERO:
		state = State.IDLE
		velocity = Vector2.ZERO
	else:
		state = State.MOVE
		velocity = input_direction * speed * delta
		player_direction = input_direction.normalized()


func _apply_animations() -> void:
	animation_tree.set("parameters/idle/blend_position", player_direction)
	animation_tree.set("parameters/move/blend_position", player_direction)
	animation_tree.set("parameters/attack/blend_position", player_direction)


func _perform_attack() -> void:
	if input_direction != Vector2.ZERO:
		player_direction = input_direction.normalized()
	_apply_attack_damage()


func _apply_attack_damage() -> void:
	if enemy != null and enemy.health > 0:
		enemy.emit_signal("hp_change", attack_damage)

	for hitbox in get_tree().get_nodes_in_group("hit"):
		if hitbox is HitBox:
			hitbox.emit_signal("hit", player_direction)


func _on_p_hitbox_body_entered(body: Node2D) -> void:
	if body is Enemy:
		enemy = body
		$damaged_timer.start()
	if body is HitBox:
		body.add_to_group("hit")


func _on_p_hitbox_body_exited(body: Node2D) -> void:
	if body is Enemy:
		$damaged_timer.stop()
	if body is HitBox:
		body.remove_from_group("hit")


func _deal_on_damage(hp: int) -> void:
	if state == State.DEAD:
		return

	health -= hp
	health = clampi(health, 0, max_health)
	print("player:", health)
	control.emit_signal("update_hp_bar", health, max_health)

	if health <= 0:
		state = State.DEAD
		print("player is killed")
		queue_free()
		return

	state = State.HURT
	hurt_timer = hurt_duration
	if enemy != null:
		knockback(enemy.velocity)


func knockback(enemy_velocity: Vector2) -> void:
	var knockback_dir := (enemy_velocity - velocity).normalized()
	if knockback_dir == Vector2.ZERO:
		knockback_dir = -player_direction
	velocity = knockback_dir * knockback_force


func _on_damage_timer_timeout() -> void:
	health += 1
	health = clampi(health, 0, max_health)


func _on_add_item_inv(item: Item) -> void:
	inventory_handler.add_to_inventory(main_inv, item, 1)
	main_inv.add(item, 1)
