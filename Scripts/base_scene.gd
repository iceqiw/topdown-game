class_name BaseScene extends Node

@onready var hero: Player = $Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if sm.hero:
		if hero:
			hero.queue_free()
		hero=sm.hero
		add_child(hero)
	
	update_pos(sm.entry)

func update_pos(entry_name):
	for entry in get_tree().get_nodes_in_group("group_entry"):
		if entry.name==entry_name:
			hero.global_position=entry.global_position
