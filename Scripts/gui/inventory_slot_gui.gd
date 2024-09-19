class_name SlotGui

extends PanelContainer

@onready var it: SlotTexture = $item
@onready var debug: Label = %debug

func update_info_with_slot(data: Slot):
	it.property = {"TEXTURE": data.item.definition.icon, "AMT": data.amount}
	
