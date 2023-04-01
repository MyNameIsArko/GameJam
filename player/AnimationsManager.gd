extends Node2D

@onready var sprite: AnimatedSprite2D = $"../AnimatedSprite2D"
@onready var player: CharacterBody2D = $".."

var current_animation = ""

func _process(delta):
	if player.is_dead:
		current_animation = "death"
		sprite.play("death")
	elif player.took_damage:
		current_animation = "dmg"
		sprite.play("dmg")
	if current_animation != "":
		return
	if player.player_direction:
		current_animation = "walk"
		sprite.play("walk")
	else:
		current_animation = "idle"
		sprite.play("idle")


func _on_animated_sprite_2d_animation_finished():
	if current_animation == "dmg":
		player.took_damage = false
	elif current_animation == "death":
		get_tree().reload_current_scene()
	current_animation = ""
