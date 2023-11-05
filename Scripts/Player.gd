extends CharacterBody2D
 
@onready var _animation_player = $AnimationPlayer

@export var speed : float = 200
@export var mass : float = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Player")
	_animation_player.play("idle_player")
	pass # Replace with function body.

func _process(_delta):
	pass

func _physics_process(delta):
	gravity_character()
	motion_ctrl()
	move_and_slide()

func gravity_character():
	velocity.y = Global.get_gravity_character(velocity.y, mass)

func motion_ctrl() -> void: 
	velocity.x = Global.get_axis().x * speed
