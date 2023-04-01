extends Node2D

@export var bullet: Resource
@export var wait_time: float = 1.0
@export var wait_random_margin: float = 0.2
var can_shoot: bool = false
@onready var enemy = $".."

var rng = RandomNumberGenerator.new()

func _ready():
	var wait = rng.randf_range(wait_time - wait_random_margin, wait_time + wait_random_margin)
	$WaitTime.start(wait)

func _process(delta):
	if can_shoot and not enemy.took_damage and not enemy.is_dead and not enemy.is_preparing:
		var instance = bullet.instantiate()
		instance.position = get_parent().position
		instance.direction = get_parent().direction
		get_tree().get_root().add_child(instance)
		$"../Audios/Shoot".play()
		can_shoot = false
		var wait = rng.randf_range(wait_time - wait_random_margin, wait_time + wait_random_margin)
		$WaitTime.start(wait)


func _on_wait_time_timeout():
	can_shoot = true
