extends Node2D

var placing: bool = false
var shape_fake: CharacterBody2D
var shape_col_poly: CollisionPolygon2D
var shape_real: RigidBody2D

var building_type: Enums.BuildingType = Enums.BuildingType.Null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("place_building") and building_type != Enums.BuildingType.Null:
		placing = true
		placing_shape()
		
	if event.is_action_released("place_building") and shape_fake != null:
		placing = false
		var shape_to_place: Resource = load("res://scenes/square.tscn")
		var shape_pos: Vector2 = shape_fake.global_position
		shape_fake.queue_free()
		shape_fake = null
		shape_col_poly = null
		
		# Check if the player can afford to build
		var game_manager = get_node("..")
		var building_to_build: Enums.Building = Enums.new().Buildings[building_type]
		if game_manager.money >= building_to_build.price:
			game_manager.money -= building_to_build.price
			shape_real = shape_to_place.instantiate()
			shape_real.global_position = shape_pos
			shape_real.building_info = building_to_build
			add_child(shape_real)
		
func _physics_process(_delta: float) -> void:
	if placing == true:
		update_shape_pos()

func placing_shape() -> void:
	# Set up building in the scene
	var shape_to_place: Resource = load("res://scenes/square_2.tscn")
	shape_fake = shape_to_place.instantiate()
	shape_col_poly = shape_fake.get_node("CollisionPolygon2D") as CollisionPolygon2D
	shape_fake.global_position = shape_init_pos()
	add_child(shape_fake)

func shape_init_pos() -> Vector2:
	# Place the building at the highest point on the screen
	var x_pos: float = get_global_mouse_position().x
	var ctrans: Transform2D = get_canvas_transform()
	var y_pos: float = (-ctrans.get_origin() / ctrans.get_scale()).y
	return Vector2(x_pos, y_pos)

func update_shape_pos() -> void:
	if (shape_fake != null):
		# Enable collision just for move and collide, to get building
		# to snap to the highest point
		shape_col_poly.disabled = false
		shape_fake.global_position = shape_init_pos()
		shape_fake.move_and_collide(Vector2(0, 2000))
		shape_col_poly.disabled = true

func _on_game_manager_selection_changed(selection: Enums.BuildingType) -> void:
	building_type = selection
