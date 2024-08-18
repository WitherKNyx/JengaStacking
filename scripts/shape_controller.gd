extends Node2D

var placing: bool = false
var shape_instance: CharacterBody2D
var shape_col_poly: CollisionPolygon2D
var shape_fake: RigidBody2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("place_building"):
		placing = true
		placing_shape()
		
	if event.is_action_released("place_building") and shape_instance != null:
		placing = false
		var shape_to_place: Resource = load("res://scenes/square.tscn")
		var shape_pos: Vector2 = shape_instance.global_position
		shape_instance.queue_free()
		shape_instance = null
		shape_col_poly = null
		shape_fake = shape_to_place.instantiate()
		shape_fake.global_position = shape_pos
		add_child(shape_fake)
		
func _physics_process(_delta: float) -> void:
	if placing == true:
		update_shape_pos()

func placing_shape() -> void:
	# Set up building in the scene
	var shape_to_place: Resource = load("res://scenes/square_2.tscn")
	shape_instance = shape_to_place.instantiate()
	shape_col_poly = shape_instance.get_node("CollisionPolygon2D") as CollisionPolygon2D
	shape_instance.global_position = shape_init_pos()
	add_child(shape_instance)

func shape_init_pos() -> Vector2:
	# Place the building at the highest point on the screen
	var x_pos: float = get_global_mouse_position().x
	var ctrans: Transform2D = get_canvas_transform()
	var y_pos: float = (-ctrans.get_origin() / ctrans.get_scale()).y
	return Vector2(x_pos, y_pos)

func update_shape_pos() -> void:
	if (shape_instance != null):
		# Enable collision just for move and collide, to get building
		# to snap to the highest point
		shape_col_poly.disabled = false
		shape_instance.global_position = shape_init_pos()
		shape_instance.move_and_collide(Vector2(0, 2000))
		shape_col_poly.disabled = true
