extends Area2D

@export var camera: Camera2D


func _on_body_entered(body):
	camera.next_camera()
	$CollisionShape2D.set_deferred("disabled", true)
	$Removing.play()
