class_name SceneHandle extends Node

var entry: String
var player: Player


func init_player(p1: Player) -> void:
	player = p1


func change_scene(entry_name: String) -> void:
	entry = entry_name

