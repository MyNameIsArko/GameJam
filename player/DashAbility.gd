extends Node2D

var can_dash: bool = true
var dash_unlocked: bool = false
@export var dash_speed: float = 1000
@onready var player = $".."

func unlock_dash():
	dash_unlocked = true
	$"../CanvasLayer/Control/DashUI".play("available")

func _input(event):
	if dash_unlocked and can_dash and Input.is_action_just_pressed("Dash"):
		can_dash = false
		player.velocity = player.player_direction * dash_speed
		player.is_dashing = true
		player.collision_layer = 0
		$"../CanvasLayer/Control/DashUI".play('charging')
		$DashImmortality.start()
		$DashTimer.start()


func _on_dash_timer_timeout():
	$"../CanvasLayer/Control/DashUI".play('available')
	can_dash = true


func _on_dash_immortality_timeout():
	player.is_dashing = false
	player.collision_layer = 1
