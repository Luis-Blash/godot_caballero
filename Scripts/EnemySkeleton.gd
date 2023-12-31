extends Node2D

@onready var _animation_player = $AnimationPlayer
@onready var _floorRaycast = $FloorRayCast

@export var mass : float = 0.6
var velocity : Vector2 = Vector2.ZERO

@export var life:float = 100


func _ready():
	print("Skeleton")
	pass # Replace with function body.

func _physics_process(delta):
	motion_ctrl()
	select_animation()

func motion_ctrl() -> void: 
	velocity.y += Global.get_gravity_character(1, mass)
	if !get_collision_floor():
		global_position.y = velocity.y
	pass

func select_animation():	
	_animation_player.play("idle_skeleton")

func get_collision_floor() -> bool:
	return _floorRaycast.is_colliding()

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		body.collision_enemy(20)

func on_recive_attack(value:float = 0):
	life -= value
