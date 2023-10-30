extends Node2D

var ScenePlayer = load("res://Scene/Player.tscn")

var SceneLevelOne = load("res://Scene/level_1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Game")
	var p = ScenePlayer.instantiate()
	var leve1 = SceneLevelOne.instantiate()
	add_child(leve1)
	add_child(p)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
