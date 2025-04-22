extends TextureRect

class_name BaseItem

#region Types and Data

enum ITEM_TYPE { 
	VEGS_AND_FRUITS, MEAT, CLOTHING,
	CLOVE, CINNAMON, GINGER,
	GOLD, BRONZE, EMERALD 
}
#endregion

@export_group("Basic Properties")
@export var item_type : ITEM_TYPE
@export_group("Market")
## Average price of this item in the market. (middle point)
@export var _market_buy_avg_rate : float = 0.0
## How much the min and max values can vary from the avg rate.
## This is floored to 0.4 to open up the range you can win or lose from haggling.
@export_range(0.4, 1.0, 0.1, "suffix:%") var _delta_buy_rate : float = 0.4

var _quality : float = 0.5

func _init() -> void:
	# 1/3 chance of getting a low quality item ([0.1, 0.4])
	_quality = randf_range(0.5, 1.0) if randi()%3 > 0 else randf_range(0.1, 0.4)
	print(self)

func get_min_market_rate() -> float:
	return _quality * (_market_buy_avg_rate * (1 - _delta_buy_rate))

func get_low_middle_point_market_rate() -> float:
	return get_min_market_rate() + ((get_avg_market_rate() - get_min_market_rate()) / 2.0)

func get_avg_market_rate() -> float:
	return _quality * (_market_buy_avg_rate)

func get_high_middle_point_market_rate() -> float:
	return _quality * (get_avg_market_rate() + ((get_max_market_rate() - get_avg_market_rate()) / 2.0))

func get_max_market_rate() -> float:
	return _quality * (_market_buy_avg_rate * (1 + _delta_buy_rate))
	
func _to_string() -> String:
	var str : String
	str += name
	str += "\tQuality " + str(_quality)
	str += "\tAvg Price " + str(_market_buy_avg_rate)
	str += "\tQuality " + str(get_min_market_rate())
	str += "\tQuality " + str(get_max_market_rate())
	return str 
	
