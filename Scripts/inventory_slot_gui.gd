extends Button

class_name SlotGui

@onready var bg: Sprite2D = $bg
@onready var container: CenterContainer = $CenterContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var _ssg: SlotStackGui

func insert(isg:SlotStackGui):
	_ssg = isg
	container.add_child(_ssg)
	
