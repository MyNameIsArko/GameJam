extends Area2D

@export var camera: Camera2D
@onready var upgrade_ui = $"../CanvasLayer/UpgradeUI"
@onready var player = $"../Player"


func _on_body_entered(body):
	upgrade_ui.show()
	get_tree().paused = true
	await player.choice_selected
	get_tree().paused = false
	camera.next_camera()
	$CollisionShape2D.set_deferred("disabled", true)
	$Removing.play()
