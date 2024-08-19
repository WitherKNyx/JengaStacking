extends RigidBody2D

var building_info: Enums.Building

var _stress: float = 0

func _on_timer_timeout() -> void:
	get_node("../..").money += building_info.revenue_production
	_stress += building_info.stress_rate
	if _stress >= 100:
		print("AH WE'RE SO STRESSED")
