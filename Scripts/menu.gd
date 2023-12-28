extends CanvasLayer

@export_file('*.tscn') var preload_scene

func _ready():
	print("inicio")

func _process(_delta):
	pass


func _on_scena_pressed():
	print("presiono")
	#get_tree().change_scene_to_packed(preload_nivelOne)
	get_tree().change_scene_to_file(preload_scene)
	pass # Replace with function body.
