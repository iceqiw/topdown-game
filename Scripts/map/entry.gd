class_name EntryPoint
extends Marker2D


@export var coordinate:String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("group_entry")
