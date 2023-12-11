extends CanvasLayer

signal update_life(value:float)

@onready var label_life = $Control/MarginContainer/HBoxContainer/P_vida

# Called when the node enters the scene tree for the first time.
func _ready():  
	print("ui")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_update_life(value):
	update_label(value)

func update_label(value:float = 10):
	if label_life:
		label_life.text = str(value)
	else:
		print("label_life es nulo.")
