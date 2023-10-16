extends CharacterBody2D
 
@onready var _animation_player = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Player")
	_animation_player.play("idle_player")
	pass # Replace with function body.

func _process(_delta):
	pass
