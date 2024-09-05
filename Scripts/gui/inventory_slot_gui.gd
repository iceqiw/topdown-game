class_name SlotGui

extends PanelContainer

@onready var bg: TextureRect = $TextureRect


func update(data: InventoryStack):
	bg.property = {"TEXTURE": data.item.texture, "CC": data.amount, "SLOT_TYPE": 0}


func _get_drag_data(at_position: Vector2) -> Variant:
	set_drag_preview(get_preview())
	return bg


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is TextureRect


func _drop_data(at_position: Vector2, data: Variant) -> void:
	var temp = bg.property
	bg.property = data.property
	data.property = temp


func get_preview():
	var preview_texture = TextureRect.new()
	preview_texture.size = Vector2(30, 30)
	preview_texture.texture = bg.texture
	preview_texture.expand_mode = 1
	var preview = Control.new()
	preview.add_child(preview_texture)
	return preview
