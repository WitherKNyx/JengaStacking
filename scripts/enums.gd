class_name Enums

enum BuildingType { 
	Null = -1,
	Type1, 
	Type2, 
	Type3, 
	Type4, 
	Type5,
	Type6,
	MaxTypes
}

var Buildings = [
	Building.new("1", 10, 100, 0),
	Building.new("2", 20, 100, 0),
	Building.new("3", 30, 100, 0),
	Building.new("4", 40, 100, 0),
	Building.new("5", 50, 100, 0),
	Building.new("6", 60, 100, 0),
]

class Building:
	var name: String
	var price: int
	var maxHealth: float
	var health: float
	var stressRate: float
	
	func _init(newName:String, newPrice: int, newMaxHealth: float, newStressRate: float):
		name = newName
		price = newPrice
		maxHealth = newMaxHealth
		health = maxHealth
		stressRate = newStressRate
	
	func _to_string() -> String:
		return "Building: %s; Cost: %d; Health: %f" % [name, price, maxHealth]
