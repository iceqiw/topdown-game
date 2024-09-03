extends CanvasLayer

class_name PlayerPanel
@onready var gui: PlayerInv = $InventoryGui

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


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
