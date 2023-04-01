extends CharacterBody2D


@export var speed: float = 300.0
@export var player_health: int = 3
var player_direction: Vector2 = Vector2.ZERO
var took_damage: bool = false
var is_dead: bool = false
var bullet_direction: Vector2 = Vector2.ZERO

func _physics_process(delta):
	if took_damage:
		move_and_slide()
		return
	if is_dead:
		return

	player_direction.x = Input.get_axis("Left", "Right")
	player_direction.y = Input.get_axis("Up", "Down")
	player_direction = player_direction.normalized()
	if player_direction:
		velocity = player_direction * speed
	else:
		velocity.x = move_toward(player_direction.x, 0, speed)
		velocity.y = move_toward(player_direction.y, 0, speed)

	move_and_slide()

func got_hit(direction_from: Vector2):
	took_damage = true
	player_health -= 1
	if player_health == 0:
		velocity = Vector2.ZERO
		is_dead = true
	else:
		velocity = direction_from * speed
	self.collision_layer = 0
	$Immortality.start()


func _on_immortality_timeout():
	self.collision_layer = 1
