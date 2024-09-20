class_name SlotTexture
extends TextureRect


@export var amount = 0:
	set(value):
		amount = value
		%amount.text = str(amount)
		%amount.visible= amount > 0

@onready var property: Dictionary = {"TEXTURE": texture, "AMT": amount}:
	set(value):
		texture = value["TEXTURE"]
		amount = value["AMT"]
