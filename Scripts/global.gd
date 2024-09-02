extends Node


var player_current_damage = false
var not_dialogue = true


var dialogue_resource :DialogueResource = preload("res://dialogic/test.dialogue")

func _ready() -> void:
	DialogueManager.dialogue_ended.connect(_end_d)

func dialogue():
	if Input.is_action_just_pressed("ui_accept") && not_dialogue:
		not_dialogue =false
		await DialogueManager.show_example_dialogue_balloon(dialogue_resource,"start")
		

func _end_d(res):
	print("end")
	not_dialogue=true
