class_name BaseScene extends Node

@export var player: Player


func _ready() -> void:
	if sm.player and is_instance_valid(sm.player):
		if player and player != sm.player:
			player.queue_free()
		player = sm.player
		player.reparent(self)
	else:
		if player == null:
			push_error("BaseScene requires an exported Player node")
			return
		sm.init_player(player)

	update_pos(sm.entry)


func update_pos(entry_name: String) -> void:
	for entry in get_tree().get_nodes_in_group("group_entry"):
		if entry.coordinate == entry_name:
			player.global_position = entry.global_position
			break


func _exit_tree() -> void:
	print("exit")
	if player and is_instance_valid(player):
		player.reparent(sm)
