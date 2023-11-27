extends Node

var score : int
var GRAVITY : float = 9.81

# Movimiento del player, ejes de movimiento
var axis : Vector2

func get_axis() -> Vector2:
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	return axis.normalized()	
	
func get_gravity_character(characterY, characterMass):
	return characterY + (characterMass * GRAVITY)



