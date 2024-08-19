extends CanvasLayer

@onready var building_select_label: Label = $BuildingSelection
@onready var money_label: Label = $DollarSign/Money
@onready var building_panels: VBoxContainer = $BuildingPanels

var panels: Array[Panel]

func _ready() -> void:
	for child in building_panels.get_children():
		panels.append(child.get_child(0))

func _process(_delta: float) -> void:
	pass

func _on_game_manager_selection_changed(selection: Enums.BuildingType) -> void:
	var formatStr = "None"
	if (selection != Enums.BuildingType.Null):
		formatStr = Enums.new().Buildings[selection]
	building_select_label.text = "Selected Building: %s" % formatStr
	
	for i in 6:
		panels[i].modulate = Color(1, 1, 1, 1) if i == selection else Color(0, 0, 0, 1)

func _on_game_manager_money_update(money: int) -> void:
	money_label.text = "%d" % money
