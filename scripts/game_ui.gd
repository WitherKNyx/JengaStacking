extends CanvasLayer

@export var BuildingSelection: Label

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass


func _on_game_manager_selection_changed(selection: Enums.BuildingType) -> void:
	var formatStr = "None"
	if (selection != Enums.BuildingType.Null):
		formatStr = Enums.new().Buildings[selection]
	BuildingSelection.text = "Selected Building: %s" % formatStr
