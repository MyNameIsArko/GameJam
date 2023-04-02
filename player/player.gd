extends CharacterBody2D


@export var speed: float = 300.0
@export var player_health: float = 3
@export var fire_bullet: Resource
var player_direction: Vector2 = Vector2.ZERO
var armor: float = 0
var damage_amplifier: float = 0
var took_damage: bool = false
var is_dead: bool = false
var bullet_direction: Vector2 = Vector2.ZERO
var is_transitioning: bool = false
var is_dashing: bool = false
signal choice_selected

var upgrade_index = 0
var taken_upgrades = 0

func _physics_process(delta):
	if is_transitioning:
		return
	if took_damage or is_dashing:
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

func got_hit(direction_from: Vector2, damage: float):
	took_damage = true
	player_health -= (1 - armor) * damage
	if player_health <= 0:
		velocity = Vector2.ZERO
		collision_layer = 0
		$"../Camera/CanvasLayer/TextureRect".calculate_hp(0)
		is_dead = true
	else:
		$"../Camera/CanvasLayer/TextureRect".calculate_hp(player_health)
		velocity = direction_from * speed
	self.collision_layer = 0
	$Immortality.start()


func _on_immortality_timeout():
	self.collision_layer = 1

func end_upgrade():
	upgrade_index += 1
	emit_signal("choice_selected")
	$CanvasLayer/ColorRect.color.a = taken_upgrades * 19.0 / 200.0
	print($CanvasLayer/ColorRect.color.a)
	$"../CanvasLayer/UpgradeUI".hide()

func _on_accept_button_up():
	taken_upgrades += 1
	match upgrade_index:
		0:
			damage_amplifier += 1
			$"../Camera".shake_amount += 10
		1:
			$DashAbility.unlock_dash()
		2:
			armor += 0.5
			$FireBallAbility.unlock_fireball()
		3:
			damage_amplifier += 1
			$"../Camera".shake_amount += 10
	end_upgrade()


func _on_reject_button_up():
	end_upgrade()
