extends CanvasLayer

class_name PlayerPanel
@onready var gui: PlayerInv = $InventoryGui

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("i"):
		if gui.is_open == false:
			gui.open()
		else :
			gui.close()


func _on_inventory_gui_closed() -> void:
	get_tree().paused=false


func _on_inventory_gui_opened() -> void:
	get_tree().paused=true
