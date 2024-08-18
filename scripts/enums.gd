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
	Building.new("1", 10, 1, 100, 0),
	Building.new("2", 20, 2, 100, 0),
	Building.new("3", 30, 3, 100, 0),
	Building.new("4", 40, 4, 100, 0),
	Building.new("5", 50, 5, 100, 0),
	Building.new("6", 60, 6, 100, 0),
]

class Building:
	var name: String
	var price: int
	var revenue_production: int
	var max_health: float
	var health: float
	var stress_rate: float
	
	func _init(new_name:String, new_price: int, new_revenue_production: int, \
		new_max_health: float, new_stress_rate: float):
		name = new_name
		price = new_price
		revenue_production = new_revenue_production
		max_health = new_max_health
		health = new_max_health
		stress_rate = new_stress_rate
	
	func _to_string() -> String:
		return "Building: %s; Cost: %d; Revenue: %d; Health: %.0f" % [name, price, revenue_production, max_health]
