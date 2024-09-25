class_name TransactionSlotUI
extends SlotGui

func _ready():
	clear_info()
	
func update_info_with_item(slot : Slot):
	super.update_info_with_item(slot)
	visible = slot.amount > 0
	self.global_position = get_global_mouse_position() - size/2


func clear_info():
	super.clear_info()
	self.visible = false


func _process(_delta):
	if self.visible:
		self.global_position = get_global_mouse_position()  - size/2 
