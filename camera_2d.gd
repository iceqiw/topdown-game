extends Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var ground = get_tree().get_first_node_in_group("ground")
	var map_rect=ground.get_used_rect()
	var tile_size=ground.rendering_quadrant_size
	var world_size=map_rect.size * tile_size
	limit_bottom=world_size.y
	limit_right=world_size.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
