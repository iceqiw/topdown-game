extends Panel

@onready var d: Sprite2D = $d
@onready var dg: Sprite2D = $CenterContainer/Panel/dg

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func update(item:InventoryThings):
	if !item:
		dg.visible=false
	else :
		dg.texture=item.texture
		dg.visible=true
