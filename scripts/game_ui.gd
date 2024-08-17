extends CanvasLayer

@export var BuildingSelection: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_game_manager_selection_changed(selection: Enums.BuildingType) -> void:
	var formatStr = "None"
	if (selection != Enums.BuildingType.Null):
		formatStr = Enums.new().Buildings[selection]
	BuildingSelection.text = "Selected Building: %s" % formatStr
