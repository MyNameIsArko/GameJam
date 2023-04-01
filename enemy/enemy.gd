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
		velocity = Vector2.ZERO
		is_dead = true
	else:
		velocity = direction_from * speed

func _process(delta):
	if took_damage:
		move_and_slide()
		return
	if is_dead or player == null or is_preparing:
		return
	direction = player.position - position
	direction = direction.normalized()
	velocity = direction * speed
	
	move_and_slide()
