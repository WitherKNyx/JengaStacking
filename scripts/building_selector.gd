extends MarginContainer

@onready var panel: Panel = $Panel
@onready var collision_shape: CollisionShape2D = $Area2D/CollisionShape2D

func _on_mouse_entered() -> void:
	panel.size = 72 * Vector2.ONE
	panel.position /= 2
	collision_shape.scale *= 1.125

func _on_mouse_exited() -> void:
	panel.size = 64 * Vector2.ONE
	panel.position *= 2
	collision_shape.scale /= 1.125

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("place_building"):
		var game_ui: CanvasLayer = get_node("../..")
		var game_man: Node = game_ui.get_node("..")
		for i in 6:
			if panel == game_ui.panels[i]:
				game_man.curr_selection = \
					i if i != game_man.curr_selection else Enums.BuildingType.Null
				break
				
