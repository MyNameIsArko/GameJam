extends Area2D

@export var move_speed: float
var direction: Vector2 = Vector2.ZERO

func _process(delta):
	assert(direction != Vector2.ZERO, "Direction not set!")
	position += direction * move_speed * delta



func _on_body_entered(body):
	if body.has_method('got_hit'):
		body.got_hit(direction)
	queue_free()
