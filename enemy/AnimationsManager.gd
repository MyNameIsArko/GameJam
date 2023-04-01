extends Node2D

@onready var enemy = $".."
@onready var sprite: AnimatedSprite2D = $"../AnimatedSprite2D"

@onready var wave_manager: Node2D = get_parent().get_parent()
var current_animation = "idle"


func _process(delta):
	if enemy.is_dead:
		current_animation = "death"
		sprite.play("death")
		$"../Audios/Death".play()
	elif enemy.took_damage:
		current_animation = "dmg"
		sprite.play("dmg")
		$"../Audios/Hit".play()
	if current_animation != "":
		return
	if enemy.direction:
		current_animation = "walk"
		sprite.play("walk")
		$"../Audios/Walk".play()
	
func _on_animated_sprite_2d_animation_finished():
	if current_animation == "dmg":
		enemy.took_damage = false
	elif current_animation == "death":
		wave_manager.remove_enemy()
		enemy.queue_free()
	elif current_animation == "idle":
		enemy.is_preparing = false
	current_animation = ""
