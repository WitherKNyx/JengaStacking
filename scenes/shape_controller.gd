extends Node2D

var placing = false
var shape_instance
var poly
var raycast = RayCast2D.new()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _unhandled_input(_event) -> void:
	if Input.is_action_just_pressed("input"):
		placing = true
		placing_shape()
		
func _physics_process(delta: float) -> void:
	if placing == true:
		var mouse_position = get_global_mouse_position()
		var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
		var query = PhysicsRayQueryParameters2D.create(global_position, get_global_mouse_position())
		var result = space_state.intersect_ray(query)
		if result:
			print("Hit at point: ", result.position)
		var rounded_position = Vector2(int(round(mouse_position.x)), int(round(mouse_position.y)))
		shape_instance.global_position = rounded_position

func placing_shape() -> void:
	var shape_to_place = load("res://scenes/square.tscn")
	shape_instance = shape_to_place.instantiate()
	shape_instance.set_freeze_enabled(true)
	poly = shape_instance.get_child(1)
	poly.disabled = true
	shape_instance.add_child(raycast)
	add_child(shape_instance)
