extends CharacterBody2D
 
@onready var _animation_player = $AnimationPlayer
@onready var _sprite_player = $Sprite2D
@onready var _colisionBody = $CollisionShape2D

@export var speed : float = 200
@export var mass : float = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Player")
	pass # Replace with function body.

func _process(_delta):
	
	pass

func _physics_process(delta):
	gravity_character()
	motion_ctrl()
	move_and_slide()
	select_animation()

func gravity_character():
	velocity.y = Global.get_gravity_character(velocity.y, mass)

func motion_ctrl() -> void: 
	velocity.x = Global.get_axis().x * speed
	
func select_animation():
	if(Input.is_action_pressed("ui_left") || Input.is_action_pressed("ui_right")):
		if(Input.is_action_pressed("ui_left")):
			_sprite_player.flip_h = true
			_colisionBody.transform[2] = Vector2(5,22)
			_animation_player.play("run_player")
		else: 
			_sprite_player.flip_h = false
			_colisionBody.transform[2] = Vector2(-5,22)
			_animation_player.play("run_player")
	else :
		_animation_player.play("idle_player")
	#_animation_player.play("idle_player")
	pass
