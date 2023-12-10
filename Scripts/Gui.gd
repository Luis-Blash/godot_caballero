extends CanvasLayer

signal  update_life_status(value:float)
@onready var label_life = $Control/HBoxContainer/P_vida
# Called when the node enters the scene tree for the first time.
func _ready():  
	print("ui")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_update_life_status(value):
	var changue_string = str(value)
	label_life.text = changue_string
