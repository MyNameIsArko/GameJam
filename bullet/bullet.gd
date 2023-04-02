extends Area2D

@export var move_speed: float
@export var damage: float = 1
var direction: Vector2 = Vector2.ZERO

func _process(delta):
	if direction == Vector2.ZERO:
		queue_free()
	position += direction * move_speed * delta


func _on_body_entered(body):
	if body.has_method('got_hit'):
		body.got_hit(direction, damage)
	queue_free()
