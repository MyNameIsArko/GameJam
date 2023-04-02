extends Node2D

var can_fireball: bool = true
var fireball_unlocked: bool = false
@onready var player = $".."
@export var fireball: Resource

func unlock_fireball():
	fireball_unlocked = true
	$"../CanvasLayer/Control/FireballUI".play("available")

func _input(event):
	if fireball_unlocked and can_fireball and Input.is_action_just_pressed("Fireball"):
		can_fireball = false
		var instance = fireball.instantiate()
		instance.position = get_parent().position
		instance.scale += Vector2.ONE * player.damage_amplifier
		instance.direction = player.get_node("AnimationsManager").direction
		instance.damage += player.damage_amplifier
		get_tree().get_root().add_child(instance)
		$"../CanvasLayer/Control/FireballUI".play('charging')
		$FireballTimer.start()

func _on_fireball_timer_timeout():
	$"../CanvasLayer/Control/FireballUI".play('available')
	can_fireball = true
