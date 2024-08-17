class_name BuildingShape
extends Node

@export var _revenueProduction: int = 1
var _stress: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_stress = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func getRevenue() -> int:
	return _revenueProduction
	
func addStress(newStress: int) -> void:
	_stress += newStress

func getStress() -> int:
	return _stress
