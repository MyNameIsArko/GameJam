extends Node2D

@export var bullet: Resource
var can_shoot: bool = true
@onready var enemy = $".."


func _process(delta):
	if can_shoot and not enemy.took_damage and not enemy.is_dead and not enemy.is_preparing:
		var instance = bullet.instantiate()
		instance.position = get_parent().position
		instance.direction = get_parent().direction
		get_tree().get_root().add_child(instance)
		can_shoot = false
		$WaitTime.start()


func _on_wait_time_timeout():
	can_shoot = true
