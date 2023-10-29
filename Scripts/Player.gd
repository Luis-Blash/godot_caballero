extends CharacterBody2D
 
@onready var _animation_player = $AnimationPlayer

@export var speed : float

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Player")
	_animation_player.play("idle_player")
	pass # Replace with function body.

func _process(_delta):
	motion_ctrl()
	pass
	
func motion_ctrl() -> void: 
	velocity.x = Global.get_axis().x * speed
	#velocity.y = Global.get_axis().y * speed
	move_and_slide()
