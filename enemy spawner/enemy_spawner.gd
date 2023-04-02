extends Node2D

@export var enemies: Array
@export var doors_path: Array[NodePath]
@onready var doors = doors_path.map(get_node)
var current_room = 0
var current_wave = 0

func _ready():
	next_wave()

func next_wave():
	$HoldTimer.start()

func create_wave():
	if current_room >= len(enemies):
		print('end!')
		return
	if current_wave >= len(enemies[current_room]):
		doors[current_room].get_node("CollisionShape2D").disabled = true
		doors[current_room].get_node("AnimatedSprite2D").play("opening")
	else:
		var instance = enemies[current_room][current_wave].instantiate()
		add_child(instance)
		current_wave += 1

func reappear_door():
	doors[current_room].get_node("CollisionShape2D").disabled = false
	doors[current_room].get_node("AnimatedSprite2D").play("closed")

func _on_hold_timer_timeout():
	create_wave()

func next_room():
	reappear_door()
	$NextLevelTimer.start()

func _on_next_level_timer_timeout():
	current_room += 1
	current_wave = 0
	create_wave()
