class_name SlotTexture
extends TextureRect

@export var slot_type: int = 0

@export var cc = 0:
	set(value):
		cc = value
		%debug.text = str(cc)

@onready var property: Dictionary = {"TEXTURE": texture, "CC": cc, "SLOT_TYPE": slot_type}:
	set(value):
		property = value
		texture = value["TEXTURE"]
		cc = value["CC"]
		slot_type = value["SLOT_TYPE"]
