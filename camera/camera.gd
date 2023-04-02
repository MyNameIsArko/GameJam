extends Camera2D

@export var camera_positions: Array[Vector2]
@export var camera_duration: float = 0.5
var current = 0
@export var shake_amount = 0
var shake = 0.0
@export var shake_duration = 0.3
@export var spawner: Node2D
@export var player: Node2D
signal shake_signal
var rng = RandomNumberGenerator.new()

func _ready():
	shake_signal.connect(shake_camera)

func next_camera():
	player.is_transitioning = true
	player.position.y -= 240
	current += 1
	var next_position = camera_positions[current]
	var tween = create_tween()
	tween.tween_property(self, 'position', next_position, camera_duration)
	if current % 2 != 0:
		create_tween().tween_property(self, 'zoom', Vector2.ONE * 0.5, camera_duration)
	else:
		create_tween().tween_property(self, 'zoom', Vector2.ONE, camera_duration)
	await tween.finished
	player.is_transitioning = false
	spawner.next_room()

func shake_camera():
	shake = shake_amount
	create_tween().tween_property(self, 'shake', 0, shake_duration)

func _process(delta):
	set_offset(Vector2(rng.randf_range(-1.0, 1.0) * shake, rng.randf_range(-1.0, 1.0) * shake))
