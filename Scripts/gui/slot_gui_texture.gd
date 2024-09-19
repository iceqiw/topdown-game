class_name SlotTexture
extends TextureRect


@export var amount = 0:
	set(value):
		amount = value
		%debug.text = str(amount)
		if amount==0:
			%debug.visible=false

@onready var property: Dictionary = {"TEXTURE": texture, "AMT": amount}:
	set(value):
		texture = value["TEXTURE"]
		amount = value["AMT"]
