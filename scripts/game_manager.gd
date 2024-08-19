extends Node2D

var can_scroll: bool = true
var money: int:
	set(value):
		money = value
		MoneyUpdate.emit(money)

@export var curr_selection: Enums.BuildingType:
	set(value):
		curr_selection = value
		SelectionChanged.emit(curr_selection)

@onready var scroll_delay = $ScrollDelay
@onready var camera = $Camera
@onready var shape_controller = $ShapeController

signal SelectionChanged(selection: Enums.BuildingType)
signal MoneyUpdate(money: int)

func _ready() -> void:
	money = 100
	curr_selection = Enums.BuildingType.Null

func _process(_delta: float) -> void:
	if camera.can_move_cam == false and shape_controller.shape_fake != null and \
		abs(camera.desired_pos.y - shape_controller.shape_fake.global_position.y) > 15:
		camera.desired_pos = Vector2(0, round(shape_controller.shape_fake.global_position.y))

func _input(event: InputEvent) -> void:
#region Selecting Building
	# Scroll has a delay to allow for actual ability to scroll,
	# instead of having to do a single movement of the scroll wheel
	if can_scroll and event.is_action_released("cycle_select_up"):
		can_scroll = false
		scroll_delay.start()
		# Cycles to next selection
		curr_selection = ((int(curr_selection) + 1) % int(Enums.BuildingType.MaxTypes)) as Enums.BuildingType
		SelectionChanged.emit(curr_selection)
	if can_scroll and event.is_action_released("cycle_select_down"):
		can_scroll = false
		scroll_delay.start()
		# Cycles to prev selection, underflow case must be handled specially
		curr_selection = (curr_selection - 1)  as Enums.BuildingType
		if curr_selection == Enums.BuildingType.Null - 1:
			curr_selection = (int(Enums.BuildingType.MaxTypes) - 1) as Enums.BuildingType
		SelectionChanged.emit(curr_selection)
	for i in Enums.BuildingType.MaxTypes:
		if event.is_action_pressed( "select_build_%d" % (i + 1) ):
			# If the current selection is the same as would be selected,
			# instead deselect that part
			curr_selection = \
				i as Enums.BuildingType if int(curr_selection) != i \
				else Enums.BuildingType.Null
			SelectionChanged.emit(curr_selection)
			break
#endregion
		
	#if event.is_action_pressed("edit_building"):
		#print("Building Edit?")

func _on_scroll_delay_timeout() -> void:
	can_scroll = true
