extends Node2D

@export var enemies: Array[Resource]
var current = 0

func _ready():
	next_wave()

func next_wave():
	if current >= len(enemies):
		pass
	else:
		var instance = enemies[current].instantiate()
		add_child(instance)
		current += 1
