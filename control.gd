extends Control
class_name StatusBar
signal update_hp_bar(hp,max_hp)

@onready var hp_bar: TextureProgressBar = $TextureProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hp_bar.value=100
	update_hp_bar.connect(_update_bar)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _update_bar(hp,max_hp):
	hp_bar.value=hp
