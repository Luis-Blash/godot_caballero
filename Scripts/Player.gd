extends CharacterBody2D
 
@onready var _animation_player = $AnimationPlayer
@onready var _sprite_player = $Sprite2D
@onready var _colisionBody = $CollisionShape2D

@export var speed : float = 200
@export var mass : float = 3
var is_jumping: bool = false
@export var jump_speed: float = 400

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Player")
	pass # Replace with function body.

func _process(_delta):
	
	pass

func _physics_process(delta):
	motion_ctrl()
	select_animation()
	move_and_slide()

func motion_ctrl() -> void: 
	velocity.x = Global.get_axis().x * speed
	
	# si esta tocando el suelo puedes saltar
	if is_on_floor() and Input.is_action_just_pressed("ui_up"):
		velocity.y = -jump_speed
		is_jumping = true
	
	# Si esta saltando
	if is_jumping:
		is_jumping = false
	# si no salta le afecta la gravedad
	else:
		velocity.y = Global.get_gravity_character(velocity.y, mass)
		
	
func select_animation():
	
	#if(is_on_floor()):
	#	print("esta tocando el suelo")
	#else: 
	#	print("esta en el cielo")
	
	
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
