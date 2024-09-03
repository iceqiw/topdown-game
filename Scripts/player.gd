class_name Player extends CharacterBody2D

const SPEED = 5000.0
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var control: StatusBar = $panel/Control
@onready var effect: AnimationPlayer = $Effect

@export var inventory:Inventory

var is_attacking := false
var is_idle := true
var is_moving := false
var is_dead := false
var is_damaged :=false
var damaged_cooldown := true
var input_direction = Vector2.ZERO
var player_direction =Vector2.LEFT
var enemy: Enemy

var health = 100
signal take_damage(hp)

var is_pause=false
signal pause
 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	take_damage.connect(_deal_on_damage)
	


func _physics_process(delta: float) -> void:
	move(delta)
	attack()
	gs.dialogue() 


func update_direction() -> Vector2:
	return Input.get_vector("left", "right", "up", "down")

func move(delta: float) -> void:
	input_direction = update_direction()
	if input_direction == Vector2.ZERO:
		is_idle = true
		is_moving = false
		is_attacking=false
		velocity = Vector2.ZERO
	else:
		velocity = input_direction * SPEED * delta
		player_direction = input_direction.normalized()
		animation_tree.set("parameters/idle/blend_position", player_direction)
		animation_tree.set("parameters/move/blend_position", player_direction)
		animation_tree.set("parameters/attack/blend_position", player_direction)
		is_idle = false
		is_moving = true
		if !is_attacking:
			move_and_slide()


func _on_p_hitbox_body_entered(body: Node2D) -> void:
	if body is Enemy:
		enemy=body
		print(body.velocity)
		$damaged_timer.start()
	if body is HitBox:
		body.add_to_group("hit")

		
func _on_p_hitbox_body_exited(body: Node2D) -> void:
	if body is Enemy:
		is_damaged=false
		$damaged_timer.stop()
	if body is HitBox:
		body.remove_from_group("hit")


func attack():
	if Input.is_action_pressed("attack"):
		is_attacking=true
		if input_direction != Vector2.ZERO:
			player_direction = input_direction.normalized()
			animation_tree.set("parameters/attack/blend_position", player_direction)
		act_damage()
		for hibbox in get_tree().get_nodes_in_group("hit"):
			if hibbox is HitBox:
				hibbox.emit_signal("hit",player_direction)
	if Input.is_action_just_released("attack"):
		is_attacking=false
		
func act_damage():
	if null != enemy:
		enemy.emit_signal("hp_change",20)
	
func _deal_on_damage(hp):
	health -= hp
	print("player:", health)
	is_damaged=true
	knockback(enemy.velocity)
	control.emit_signal("update_hp_bar",health,100)
	if health <= 0:
		is_dead = true
		print("player is killed")
		self.queue_free()
		
func knockback(enemy_velocity:Vector2):
	var knockbackdir=(enemy_velocity-velocity).normalized() * 500
	velocity=knockbackdir
	move_and_slide()

func _on_damage_timer_timeout() -> void:
	damaged_cooldown = true;
	health+=1

#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("pause"):
		#if is_pause==false:
			#get_tree().paused=true
		#else :
			#is_pause=false
			#get_tree().paused=false
