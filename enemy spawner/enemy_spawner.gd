extends Node2D

@export var enemies: Array[Resource]
@export var door: Node2D
var current = 0

func _ready():
	next_wave()

func next_wave():
	$HoldTimer.start()

func create_wave():
	if current >= len(enemies):
		door.queue_free()
	else:
		var instance = enemies[current].instantiate()
		add_child(instance)
		current += 1

func _on_hold_timer_timeout():
	create_wave()
