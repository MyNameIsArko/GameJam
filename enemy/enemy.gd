extends CharacterBody2D

@export var enemy_health: int = 3
@export var speed: float = 200
var player

var is_preparing: bool = true
var rng = RandomNumberGenerator.new()

var direction: Vector2 = Vector2.ZERO
var is_dead: bool = false
var took_damage: bool = false
@onready var navigation = $NavigationAgent2D

func _ready():
	player = get_tree().get_nodes_in_group("Player")[0]
	_on_change_location_timeout()

func got_hit(direction_from: Vector2, damage: float):
	get_parent().get_parent().get_parent().get_node("Camera").shake_signal.emit()
	took_damage = true
	enemy_health -= damage
	if enemy_health <= 0:
		velocity = Vector2.ZERO
		is_dead = true
	else:
		velocity = direction_from * speed

func _physics_process(delta):
	if took_damage:
		move_and_slide()
		return
	if is_dead or player == null or is_preparing:
		return
	direction = direction.normalized()
	velocity = direction * speed
	
	move_and_slide()


func _on_change_location_timeout():
	if rng.randf() < 0.2:
		direction = Vector2(rng.randf_range(-1, 1), rng.randf_range(-1, 1))
	else:
		navigation.target_position = player.position
		var dir_position = navigation.get_next_path_position()
		direction = dir_position - global_position
