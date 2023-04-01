extends CharacterBody2D


@export var SPEED: float = 300.0
@export var player_health: int = 3
var player_direction: Vector2 = Vector2.ZERO
var took_damage: bool = false
var is_dead: bool = false


func _physics_process(delta):
	if took_damage or is_dead:
		return

	player_direction.x = Input.get_axis("Left", "Right")
	player_direction.y = Input.get_axis("Up", "Down")
	player_direction = player_direction.normalized()
	if player_direction:
		velocity = player_direction * SPEED
	else:
		velocity.x = move_toward(player_direction.x, 0, SPEED)
		velocity.y = move_toward(player_direction.y, 0, SPEED)

	move_and_slide()

func got_hit(direction_from: Vector2):
	took_damage = true
	player_health -= 1
	if player_health == 0:
		is_dead = true
