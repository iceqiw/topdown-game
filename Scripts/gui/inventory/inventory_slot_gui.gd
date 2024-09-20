class_name SlotGui

extends Control

@onready var it: SlotTexture = $item
@export var highlight_color = Color.ORANGE

func update_info_with_slot(slot : Slot):
	if slot != null and slot.has_valid():
		update_info_with_item(slot)
		return
	it.property = {"TEXTURE": null, "AMT": 0}
	
func clear_info():
	it.property = {"TEXTURE": null, "AMT": 0}


func update_info_with_item(slot : Slot):
	if slot.has_valid():
		it.property = {"TEXTURE": slot.item.definition.icon, "AMT": slot.amount}
	else:
		clear_info()


	
func _on_mouse_entered():
	print("grab_focus")
	grab_focus()


func _on_mouse_exited():
	print("release_focus")
	release_focus()
	
func _on_focus_entered() -> void:
	$Panel.self_modulate = highlight_color


func _on_focus_exited() -> void:
	$Panel.self_modulate = Color.WHITE
