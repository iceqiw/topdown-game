extends CharacterBody2D


const SPEED = 60.0
@onready var animation_tree: AnimationTree = $AnimationTree
var input_direction = Vector2(0, 1)

func _physics_process(delta: float) -> void:
	move()


func move() -> void:
	if input_direction.y == 0:
		input_direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	if input_direction.x == 0:
		input_direction.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	velocity=input_direction * SPEED
	move_and_slide()
	
	if input_direction == Vector2.ZERO:
		animation_tree["parameters/conditions/is_idle"] = true
		animation_tree["parameters/conditions/is_moving"]= false
	else :
		animation_tree["parameters/conditions/is_idle"] = false
		animation_tree["parameters/conditions/is_moving"]= true
		animation_tree.set("parameters/idle/blend_position", input_direction)
		animation_tree.set("parameters/move/blend_position", input_direction)
