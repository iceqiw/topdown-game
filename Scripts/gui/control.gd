class_name StatusBar

extends Control
signal update_hp_bar(hp, max_hp)

@onready var hp_bar: TextureProgressBar = $TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hp_bar.value = 100
	update_hp_bar.connect(_update_bar)


func _update_bar(hp, max_hp):
	print(max_hp, "max hp")
	hp_bar.value = hp
