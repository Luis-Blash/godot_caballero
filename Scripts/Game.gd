extends Node2D

var ScenePlayer = load("res://Scene/Player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Game")
	var p = ScenePlayer.instantiate()
	add_child(p)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
