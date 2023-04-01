extends Node2D

@onready var sprite: AnimatedSprite2D = $"../AnimatedSprite2D"
@onready var player: CharacterBody2D = $".."

var current_animation = ""

func _process(delta):
	if player.is_dead:
		current_animation = "death"
		sprite.play("death")
		$"../Audios/Death".play()
	elif player.took_damage:
		current_animation = "dmg"
		sprite.play("dmg")
		$"../Audios/Hit".play()
	if current_animation != "":
		return
	if player.player_direction:
		match player.bullet_direction:
			Vector2.LEFT:
				sprite.flip_h = true
				sprite.play("walk_side")
			Vector2.RIGHT:
				sprite.flip_h = false
				sprite.play("walk_side")
			Vector2.UP:
				sprite.play("walk_up")
			Vector2.DOWN:
				sprite.play("walk_down")
		$"../Audios/Walk".play()
	else:
		sprite.play("idle")


func _on_animated_sprite_2d_animation_finished():
	if current_animation == "dmg":
		player.took_damage = false
	elif current_animation == "death":
		get_tree().reload_current_scene()
	current_animation = ""
