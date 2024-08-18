extends CanvasLayer

@export var building_select_label: Label
@export var money_label: Label

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func _on_game_manager_selection_changed(selection: Enums.BuildingType) -> void:
	var formatStr = "None"
	if (selection != Enums.BuildingType.Null):
		formatStr = Enums.new().Buildings[selection]
	building_select_label.text = "Selected Building: %s" % formatStr

func _on_game_manager_money_update(money: int) -> void:
	money_label.text = "Money: $%d" % money
