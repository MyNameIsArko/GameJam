extends Control

func _input(event):
	if Input.is_key_pressed(KEY_SPACE):
		get_tree().change_scene_to_file("res://scenes/world.tscn")
