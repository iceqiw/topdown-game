extends CanvasLayer

class_name Cly
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var color_rect: ColorRect = $ColorRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color_rect.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func play():
	color_rect.show()
	set_layer(12)
	animation_player.play("change")
	await animation_player.animation_finished
	
func playback():
	animation_player.play_backwards("change")
	await animation_player.animation_finished
	color_rect.hide()
