class_name SlotGui
extends Control

@onready var amount: Label = $amount
@onready var it: TextureRect = $item
@onready var bg: TextureRect = $bg
@export var highlight_color = Color.ORANGE

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func update_info_with_slot(slot : Slot):
	if slot != null and slot.has_valid():
		update_info_with_item(slot)
		return
	clear_info()
	
func clear_info():
	it.texture= null
	amount.visible=false


func update_info_with_item(slot : Slot):
	if slot.has_valid():
		it.texture=slot.item.definition.icon
		amount.text = str(slot.amount)
		amount.visible= slot.amount>0
	else:
		clear_info()

func _on_mouse_entered():
	get_window().grab_focus()

func _on_mouse_exited():
	get_window().release_focus()
	
func _on_focus_entered() -> void:
	$Panel.self_modulate = highlight_color


func _on_focus_exited() -> void:
	$Panel.self_modulate = Color.WHITE
