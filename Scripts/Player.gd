extends CharacterBody2D
 
@onready var _animation_player = $AnimationPlayer
@onready var _sprite_player = $Sprite2D
@onready var _colisionBody = $CollisionShape2D
@onready var _wallRaycast = $WallRayCast
@onready var _floorRaycast = $FloorRayCast

@export var speed : float = 200
@export var mass : float = 3
var is_jumping: bool = false
@export var jump_speed: float = 400

var jump_key = false
var left_key = false
var right_key = false

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Player")
	pass # Replace with function body.

func _process(_delta):
	pass

func _physics_process(delta):
	keys_press()
	motion_ctrl()
	select_animation()
	move_and_slide()
	
func keys_press():
	
	if Input.is_action_just_pressed("ui_up"):
		jump_key = true
	else:
		jump_key = false
		
	if Input.is_action_pressed("ui_left"):
		left_key = true
	else:
		left_key = false
		
	if Input.is_action_pressed("ui_right"):
		right_key = true
	else:
		right_key = false
		


func motion_ctrl() -> void: 
	
	if get_collision_floor():
		velocity = Vector2.ZERO
	
	if !get_collision_wall():
		velocity.x = Global.get_axis().x * speed
	
	# si esta tocando el suelo puedes saltar
	if get_collision_floor() and jump_key:
		if !get_collision_wall():
			velocity.y = -jump_speed
			is_jumping = true
	
	# Si esta saltando
	if is_jumping:
		is_jumping = false
	# si no salta le afecta la gravedad
	else:
		velocity.y += Global.get_gravity_character(1, mass)
		
	
func select_animation():	
	
	if ((left_key || right_key) && get_collision_floor()):
		_animation_player.play("run_player")
	else:
		_animation_player.play("idle_player")
		
	if left_key:
		_sprite_player.flip_h = true
		_colisionBody.transform[2] = Vector2(5,22)
		_wallRaycast.transform[2] = Vector2(5,22)
		_wallRaycast.target_position = Vector2(-10,0)
		_floorRaycast.transform[2] = Vector2(5,22)
	
	if right_key:
		_sprite_player.flip_h = false
		_colisionBody.transform[2] = Vector2(-5,22)
		_wallRaycast.transform[2] = Vector2(-5,22)
		_wallRaycast.target_position = Vector2(10,0)
		_floorRaycast.transform[2] = Vector2(-5,22)
		

func get_collision_wall() -> bool:
	return _wallRaycast.is_colliding()
	
func get_collision_floor() -> bool:
	return _floorRaycast.is_colliding()
