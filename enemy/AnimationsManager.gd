extends Node2D

@onready var enemy = $".."
@onready var sprite: AnimatedSprite2D = $"../AnimatedSprite2D"

@onready var wave_manager: Node2D = get_parent().get_parent()
var current_animation = "idle"
@onready var timer = $"../HitTimer"

func _process(delta):
	if enemy.is_dead:
		current_animation = "death"
		sprite.play("death")
		$"../Audios/Death".play()
	elif enemy.took_damage and timer.is_stopped():
		current_animation = "dmg"
		sprite.play("dmg")
		sprite.modulate = Color.RED
		timer.start()
		$"../Audios/Hit".play()
	if current_animation != "":
		return
	if enemy.direction:
		if enemy.direction.x > 0:
			$"../AnimatedSprite2D".flip_h = false
		else:
			$"../AnimatedSprite2D".flip_h = true
		sprite.play("walk")
		$"../Audios/Walk".play()
	
func _on_animated_sprite_2d_animation_finished():
	if current_animation == "death":
		wave_manager.remove_enemy()
		enemy.queue_free()
	elif current_animation == "idle":
		enemy.is_preparing = false
	current_animation = ""


func _on_hit_timer_timeout():
	enemy.took_damage = false
	sprite.modulate = Color.WHITE
	current_animation = ""
