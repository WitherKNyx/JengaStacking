extends RigidBody2D

func _on_panel_mouse_entered() -> void:
	get_node("../../CursorHandler").set_cursor_to_wrench()

func _on_panel_mouse_exited() -> void:
	get_node("../../CursorHandler").set_cursor_to_arrow()
