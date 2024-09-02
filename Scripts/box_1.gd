extends CharacterBody2D

class_name HitBox


signal hit(x)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hit.connect(_hitted)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _hitted(x):
	velocity = x * 100
	move_and_slide()
