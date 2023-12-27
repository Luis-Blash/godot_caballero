extends CharacterBody2D

@onready var _animation_player = $AnimationPlayer
@onready var _sprite_player = $Sprite2D
@onready var _colisionBody = $CollisionShape2D
@onready var _wallRaycast = $WallRayCast
@onready var _floorRaycast = $FloorRayCast

# colision de ataque
@onready var collision_attack_one = $AreaAttack/Attack

# salto y gravedad
var mass : float = 3
@export var speed : float = 200
var is_jumping: bool = false
@export var jump_speed: float = 400

# botones click
var jump_key = false
var left_key = false
var right_key = false
var attack_key = false

# selecion de animacion de ataque
var select_animation_attack = 0

# vida y ataque
@export var life:float = 100 
@export var attack_power:float = 10 

#recibir ataque
var is_receives_damage: bool = false
@onready var timer_damage = $TimerDamage

# instance another
@onready var gui = $"../Gui"

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Player")
	signal_custom("life_update",life)
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
	
	if Input.is_action_pressed("ui_letter_attack") && get_collision_floor():
		attack_key = true


func motion_ctrl() -> void: 
	if get_collision_floor():
		if is_receives_damage:
			on_recive_damage()
		else:
			velocity = Vector2.ZERO
	
	if !get_collision_wall() && !attack_key && !is_receives_damage:
		velocity.x = Global.get_axis().x * speed
	
	# si esta tocando el suelo puedes saltar
	if get_collision_floor() && jump_key && !attack_key && !is_receives_damage:
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
	if is_receives_damage:
		_animation_player.play("Jump_player")
		return
		
	if ((left_key || right_key) && get_collision_floor() && !attack_key):
		_animation_player.play("run_player")
		# ataque
	elif !get_collision_floor():
		_animation_player.play("Jump_player")
	else:
		if attack_key:
			if select_animation_attack == 0:
				_animation_player.play("attack_one")
			else:
				_animation_player.play("attack_two")
		else:
			_animation_player.play("idle_player")
	
	if attack_key:
		collision_attack_one.disabled = false
	else:
		collision_attack_one.disabled = true
		
	if left_key:
		_sprite_player.flip_h = true
		_colisionBody.transform[2] = Vector2(5,22)
		_wallRaycast.transform[2] = Vector2(5,22)
		_wallRaycast.target_position = Vector2(-10,0)
		_floorRaycast.transform[2] = Vector2(5,22)
		collision_attack_one.transform[2] = Vector2(-28.5, 21)
	
	if right_key:
		_sprite_player.flip_h = false
		_colisionBody.transform[2] = Vector2(-5,22)
		_wallRaycast.transform[2] = Vector2(-5,22)
		_wallRaycast.target_position = Vector2(10,0)
		_floorRaycast.transform[2] = Vector2(-5,22)
		collision_attack_one.transform[2] = Vector2(28.5, 21)
		

func get_collision_wall() -> bool:
	return _wallRaycast.is_colliding()
	
func get_collision_floor() -> bool:
	return _floorRaycast.is_colliding()


func _on_animation_player_animation_started(anim_name):
	if(anim_name == "atack_one"):
		pass
	pass # Replace with function body.

func _on_animation_player_animation_finished(anim_name):
	if(anim_name == "attack_one" || anim_name == "attack_two"):
		collision_attack_one.disabled = true
		attack_key = false
		if anim_name == "attack_one":
			select_animation_attack = 1
		else:
			select_animation_attack = 0

func collision_enemy(value:float = 10 ):
	if !is_receives_damage:
		life -= value
		signal_custom("life_update",life)
	
	is_receives_damage = true
	timer_damage.wait_time = 0.40
	timer_damage.start()
	_sprite_player.modulate = "#c22d26"
		
	if(life <= 0):
		death_persont()

func on_recive_damage():
	if _sprite_player.flip_h:
		velocity.x = 1 * speed / 2
		velocity.y = -jump_speed
	else: 
		velocity.x = -1 * speed / 2
		velocity.y = -jump_speed

func death_persont():
	print('death')

func _on_area_attack_area_entered(area):
	if (area.is_in_group("EnemyArea")):
		var enemy = area.get_parent()
		enemy.on_recive_attack(attack_power)

func signal_custom(value: String, data):
	match value:
		"life_update":
			gui.emit_signal("update_life", data)
		_:
			print('No hay')

func _on_timer_damage_timeout():
	_sprite_player.modulate = "#ffffff"
	is_receives_damage = false
