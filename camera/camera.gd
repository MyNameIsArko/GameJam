extends Camera2D

@export var camera_positions: Array[Vector2]
@export var camera_duration: float = 0.5
var current = 0

func next_camera():
	current += 1
	var next_position = camera_positions[current]
	create_tween().tween_property(self, 'position', next_position, camera_duration)
