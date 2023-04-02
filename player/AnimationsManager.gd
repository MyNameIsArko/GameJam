extends Node2D

@onready var sprite: AnimatedSprite2D = $"../AnimatedSprite2D"
@onready var player: CharacterBody2D = $".."

var current_animation = ""
var direction: Vector2 = Vector2.RIGHT
var move_direction: Vector2

func _process(delta):
	if Input.is_action_just_pressed("Down"):
		move_direction = Vector2.DOWN
	elif Input.is_action_just_pressed("Up"):
		move_direction = Vector2.UP
	elif Input.is_action_just_pressed("Left"):
		move_direction = Vector2.LEFT
	elif Input.is_action_just_pressed("Right"):
		move_direction = Vector2.RIGHT
	if player.is_dashing:
		current_animation = "dash"
		sprite.flip_h = true if move_direction == Vector2.LEFT else false
		match move_direction:
			Vector2.LEFT:
				sprite.play("dash_side")
			Vector2.RIGHT:
				sprite.play("dash_side")
			Vector2.UP:
				sprite.play("dash_up")
			Vector2.DOWN:
				sprite.play("dash_down")
	elif player.is_dead:
		current_animation = "death"
		sprite.play("death")
		$"../Audios/Death".play()
	elif player.took_damage:
		current_animation = "dmg"
		sprite.play("dmg")
		$"../Audios/Hit".play()
	match direction:
		Vector2.LEFT:
			sprite.flip_h = true
		_:
			sprite.flip_h = false
	if current_animation != "":
		return
	if player.player_direction:
		match direction:
			Vector2.LEFT:
				sprite.play("walk_side")
			Vector2.RIGHT:
				sprite.play("walk_side")
			Vector2.UP:
				sprite.play("walk_up")
			Vector2.DOWN:
				sprite.play("walk_down")
		$"../Audios/Walk".play()
	else:
		match direction:
			Vector2.LEFT:
				sprite.play("idle_side")
			Vector2.RIGHT:
				sprite.play("idle_side")
			Vector2.UP:
				sprite.play("idle_up")
			Vector2.DOWN:
				sprite.play("idle_down")

func _input(_event):
	var attack_direction: Vector2 = Vector2.ZERO
	attack_direction.x = Input.get_axis("Attack Left", "Attack Right")
	attack_direction.y = Input.get_axis("Attack Up", "Attack Down")
	
	if Input.is_action_just_pressed("Attack Down"):
		direction = Vector2.DOWN
	elif Input.is_action_just_pressed("Attack Up"):
		direction = Vector2.UP
	elif Input.is_action_just_pressed("Attack Left"):
		direction = Vector2.LEFT
	elif Input.is_action_just_pressed("Attack Right"):
		direction = Vector2.RIGHT
	if Input.is_action_just_released("Attack Down") or Input.is_action_just_released("Attack Up") or Input.is_action_just_released("Attack Left") or Input.is_action_just_released("Attack Right"):
		if attack_direction == Vector2.ZERO:
			if Input.is_action_pressed("Left"):
				direction = Vector2.LEFT
			elif Input.is_action_pressed("Right"):
				direction = Vector2.RIGHT
	elif not Input.is_action_pressed("Attack Down") and not Input.is_action_pressed("Attack Up") and not Input.is_action_pressed("Attack Left") and not Input.is_action_pressed("Attack Right"):
		if Input.is_action_just_pressed("Down"):
			direction = Vector2.DOWN
		elif Input.is_action_just_pressed("Up"):
			direction = Vector2.UP
		elif Input.is_action_just_pressed("Left"):
			direction = Vector2.LEFT
		elif Input.is_action_just_pressed("Right"):
			direction = Vector2.RIGHT
		elif Input.is_action_pressed("Down"):
			direction = Vector2.DOWN
		elif Input.is_action_pressed("Up"):
			direction = Vector2.UP
		elif Input.is_action_pressed("Left"):
			direction = Vector2.LEFT
		elif Input.is_action_pressed("Right"):
			direction = Vector2.RIGHT

func _on_animated_sprite_2d_animation_finished():
	if current_animation == "dmg":
		player.took_damage = false
	elif current_animation == "death":
		get_tree().change_scene_to_file("res://MainMenu/Menu.tscn")
	current_animation = ""
