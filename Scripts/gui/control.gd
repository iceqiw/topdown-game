class_name StatusBar

extends Control
signal update_hp_bar(hp, max_hp)

@onready var hp_bar: TextureProgressBar = $TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_hp_bar.connect(_update_bar)


func _update_bar(hp: int, max_hp: int) -> void:
	hp_bar.max_value = max_hp
	hp_bar.value = hp
