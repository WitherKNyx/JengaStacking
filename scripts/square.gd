extends RigidBody2D

var building_info: Enums.Building

var _stress: float = 0

func _on_panel_mouse_entered() -> void:
	get_node("../../CursorHandler").set_cursor_to_wrench()

func _on_panel_mouse_exited() -> void:
	get_node("../../CursorHandler").set_cursor_to_arrow()

func _on_timer_timeout() -> void:
	get_node("../..").money += building_info.revenue_production
	_stress += building_info.stress_rate
	if _stress >= 100:
		print("AH WE'RE SO STRESSED")
