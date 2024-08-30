class_name EntryPoint
extends Marker2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("group_entry")
	#print(get_tree().get_nodes_in_group("group_entry"))
