extends Node2D
class_name WaveManager

var enemies_amount: int = 0
@onready var enemy_spawner = get_parent()

func _ready():
	enemies_amount = get_child_count()

func remove_enemy():
	enemies_amount -= 1
	if enemies_amount == 0:
		enemy_spawner.next_wave()
