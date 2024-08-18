extends Camera2D

@export var cam_speed: float = 10.0

var desired_pos: Vector2 = Vector2.ZERO
var can_move_cam: bool = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if can_move_cam:
		# Continuously move camera on input
		if (Input.is_action_pressed("cam_up")):
			desired_pos.y -= cam_speed / 5
		if (Input.is_action_pressed("cam_down")):
			desired_pos.y += cam_speed / 5
	
	# Clamp camera's downward movement
	desired_pos.y = min(desired_pos.y, 0)
	global_position = exp_decay(global_position, desired_pos, 10, delta)

func _input(event: InputEvent) -> void:
	pass
	
func exp_decay(a, b, decay: float, dt: float):
	return b + (a - b) * exp(-decay * dt)
