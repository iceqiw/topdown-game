class_name Player extends CharacterBody2D

const SPEED = 5000.0
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var control: StatusBar = $CanvasLayer/Control

var is_attacking := false
var is_idle := true
var is_moving := false
var is_dead := false
var damaged_cooldown := true
var input_direction = Vector2.ZERO

var enemy: Enemy

var health = 100
signal take_damage(hp)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	take_damage.connect(_deal_on_damage)

func _physics_process(delta: float) -> void:
	move(delta)
	attack()

func update_direction() -> Vector2:
	if input_direction.y == 0:
		input_direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	if input_direction.x == 0:
		input_direction.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return input_direction

func move(delta: float) -> void:
	input_direction = update_direction()
	if input_direction == Vector2.ZERO:
		is_idle = true
		is_moving = false
		velocity = Vector2.ZERO
	elif is_attacking == false:
		velocity = input_direction * SPEED * delta
		animation_tree.set("parameters/idle/blend_position", input_direction)
		animation_tree.set("parameters/move/blend_position", input_direction)
		animation_tree.set("parameters/attack/blend_position", input_direction)
		is_idle = false
		is_moving = true
		move_and_slide()
	else:
		animation_tree.set("parameters/attack/blend_position", input_direction)


func _on_p_hitbox_body_entered(body: Node2D) -> void:
	if body is Enemy:
		enemy=body
		$damaged_timer.start()

		
func _on_p_hitbox_body_exited(body: Node2D) -> void:
	if body is Enemy:
		$damaged_timer.stop()

func attack():
	if Input.is_action_pressed("attack") :
		is_attacking=true
		act_damage()
	if Input.is_action_just_released("attack"):
		is_attacking=false
		
func act_damage():
	if null != enemy:
		enemy.emit_signal("hp_change",20)
	
func _deal_on_damage(hp):
	health -= hp
	print("player:", health)
	control.emit_signal("update_hp_bar",health,100)
	if health <= 0:
		is_dead = true
		print("player is killed")
		self.queue_free()


func _on_damage_timer_timeout() -> void:
	damaged_cooldown = true;
	health+=1
