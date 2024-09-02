extends Area2D

@export_file("*.tscn") var path: String

@export var entry_point: String

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		sm.change_scence(get_owner(),path,entry_point)
