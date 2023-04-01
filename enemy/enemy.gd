extends CharacterBody2D

@export var enemy_health: int = 3
@export var speed: float = 200
var player

var is_preparing: bool = true

var direction: Vector2 = Vector2.ZERO
var is_dead: bool = false
var took_damage: bool = false

func _ready():
	player = get_tree().get_nodes_in_group("Player")[0]

func got_hit(direction_from: Vector2):
	took_damage = true
	enemy_health -= 1
	if enemy_health == 0:
		is_dead = true

func _process(delta):
	if is_dead or took_damage or player == null or is_preparing:
		return
	direction = player.position - position
	direction = direction.normalized()
	velocity = direction * speed
	
	move_and_slide()
