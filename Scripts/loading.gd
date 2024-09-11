extends Control

# Nodes
@onready var progress: ProgressBar = find_child("Progress")
@onready var loading: AnimatedSprite2D = find_child("Loading")

var hero:Player
var entry:String

func _ready():
	SceneManager.load_percent_changed.connect(percent_changed)
	SceneManager.load_finished.connect(loading_finished)
	SceneManager.load_scene_interactive(SceneManager.get_recorded_scene())

func percent_changed(number: int) -> void:
	progress.value = number

func loading_finished() -> void:
	loading.visible = false
	var fade_out_options = SceneManager.create_options(1.0, "scribbles", 0.2, true)
	var fade_in_options = SceneManager.create_options(1.0, "crooked_tiles", 0.2, true)
	var general_options = SceneManager.create_general_options(Color(0, 0, 0), 0, false, true)
	SceneManager.add_loaded_scene_to_scene_tree()
	SceneManager.change_scene_to_existing_scene_in_scene_tree(fade_out_options, fade_in_options, general_options)
	
