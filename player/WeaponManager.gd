extends Node2D

@export var bullet: Resource
var can_shoot: bool = true

var bullet_direction: Vector2 = Vector2.ZERO

func _process(delta):
	
	if Input.is_action_just_pressed("Attack Left"):
		bullet_direction = Vector2.LEFT
	elif Input.is_action_just_pressed("Attack Right"):
		bullet_direction = Vector2.RIGHT
	elif Input.is_action_just_pressed("Attack Up"):
		bullet_direction = Vector2.UP
	elif Input.is_action_just_pressed("Attack Down"):
		bullet_direction = Vector2.DOWN
	
	var is_shooting: bool = Input.is_action_pressed("Attack Down") or Input.is_action_pressed("Attack Up") or Input.is_action_pressed("Attack Left") or Input.is_action_pressed("Attack Right")
	
	if is_shooting and can_shoot:
		var instance = bullet.instantiate()
		instance.position = get_parent().position
		instance.direction = bullet_direction
		get_tree().get_root().add_child(instance)
		can_shoot = false
		$WaitTime.start()


func _on_wait_time_timeout():
	can_shoot = true
