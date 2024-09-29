class_name BaseScene extends Node

@export var player: Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if sm.player:
		if player:
			player.queue_free()
		player=sm.player
		add_child(player)
	else:
		sm.init_player(player)
	
	update_pos(sm.entry)

func update_pos(entry_name):
	for entry in get_tree().get_nodes_in_group("group_entry"):
		if entry.coordinate==entry_name:
			player.global_position=entry.global_position

func _exit_tree() -> void:
	print("exit")
	remove_child(player)
