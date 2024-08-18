extends Node2D

var canScroll: bool = true
var money: int = 100
@export var curr_selection: Enums.BuildingType = Enums.BuildingType.Null
@onready var scrollDelayTimer = $ScrollDelay

signal SelectionChanged(selection: Enums.BuildingType)

func _ready() -> void:
	SelectionChanged.emit(curr_selection)

func _process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	# Selecting Building
	if (canScroll and event.is_action_released("cycle_select_up")):
		canScroll = false
		scrollDelayTimer.start()
		curr_selection = ((int(curr_selection) + 1) % int(Enums.BuildingType.MaxTypes)) as Enums.BuildingType
		SelectionChanged.emit(curr_selection)
	if (canScroll and event.is_action_released("cycle_select_down")):
		canScroll = false
		scrollDelayTimer.start()
		curr_selection = (curr_selection - 1)  as Enums.BuildingType
		if curr_selection == Enums.BuildingType.Null - 1:
			curr_selection = (int(Enums.BuildingType.MaxTypes) - 1) as Enums.BuildingType
		SelectionChanged.emit(curr_selection)
	for i in Enums.BuildingType.MaxTypes:
		if (event.is_action_pressed( "select_build_%d" % (i + 1) )):
			curr_selection = \
				i as Enums.BuildingType if int(curr_selection) != i \
				else Enums.BuildingType.Null
			SelectionChanged.emit(curr_selection)
			break
	
	if (event.is_action_pressed("place_building")):
		print("Building Place?")
		pass
		
	if (event.is_action_pressed("edit_building")):
		print("Building Edit?")
		pass


func _on_scroll_delay_timeout() -> void:
	canScroll = true
	print("Happy Scrolling!")
