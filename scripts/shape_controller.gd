extends Node2D

var placing = false
var shape_instance: CharacterBody2D
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
		shape_fake = shape_to_place.instantiate()
		shape_fake.global_position = shape_pos
		add_child(shape_fake)
		
func _physics_process(_delta: float) -> void:
	if placing == true:
		update_shape_pos()

func placing_shape() -> void:
	var shape_to_place: Resource = load("res://scenes/square_2.tscn")
	shape_instance = shape_to_place.instantiate()
	
	var x_pos: float = get_global_mouse_position().x
	var ctrans: Transform2D = get_canvas_transform()
	var y_pos: float = (-ctrans.get_origin() / ctrans.get_scale()).y
	var rounded_position: Vector2 = Vector2(x_pos, y_pos)
	shape_instance.global_position = rounded_position
	
	add_child(shape_instance)

func update_shape_pos() -> void:
	var x_pos: float = get_global_mouse_position().x
	var ctrans: Transform2D = get_canvas_transform()
	var y_pos: float = (-ctrans.get_origin() / ctrans.get_scale()).y
	var rounded_position: Vector2 = Vector2(x_pos, y_pos)
	if (shape_instance != null):
		shape_instance.global_position = rounded_position
		shape_instance.move_and_collide(Vector2(0, 2000))
