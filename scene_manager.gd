class_name SceneManger extends Node

var hero:Player
var entry:String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func change_scence(from,path,entry_name:String) -> void:
	hero=from.hero
	entry=entry_name
	hero.get_parent().remove_child(hero)
	cct.play()
	from.get_tree().call_deferred("change_scene_to_file",path)
	cct.playback()
	
