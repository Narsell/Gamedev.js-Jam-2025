extends Control

class_name BaseItem

#region Types and Data
enum ITEM_CATEGORY { COMMON, SPICES, ORES }

enum ITEM_TYPE { 
	VEGS_AND_FRUITS, MEAT, CLOTHING,
	CLOVE, CINNAMON, GINGER,
	GOLD, BRONZE, EMERALD 
}

static var AVAILABLE_ITEMS : Dictionary = {
	ITEM_CATEGORY.COMMON : [
		ITEM_TYPE.VEGS_AND_FRUITS,
		ITEM_TYPE.MEAT,
		ITEM_TYPE.CLOTHING
	],
	ITEM_CATEGORY.SPICES : [
		ITEM_TYPE.CLOVE,
		ITEM_TYPE.CINNAMON,
		ITEM_TYPE.GINGER
	],
	ITEM_CATEGORY.ORES : [
		ITEM_TYPE.GOLD,
		ITEM_TYPE.BRONZE,
		ITEM_TYPE.EMERALD
	]
}
#endregion

@export_group("Basic Properties")
@export var category : ITEM_CATEGORY
@export var item_type : ITEM_TYPE

@export_group("Price")
## Average price of this item in the market. (middle point)
@export var _market_buy_avg_rate : float = 0.0
## How much the min and max values can vary from the avg rate.
## This is floored to 0.4 to open up the range you can win or lose from haggling.
@export_range(0.4, 1.0, 0.1, "suffix:%") var _delta_buy_rate : float = 0.0

func get_min_market_rate() -> float:
	return _market_buy_avg_rate * (1 - _delta_buy_rate)

func get_low_middle_point_market_rate() -> float:
	return get_min_market_rate() + ((get_avg_market_rate() - get_min_market_rate()) / 2.0)

func get_avg_market_rate() -> float:
	return _market_buy_avg_rate

func get_high_middle_point_market_rate() -> float:
	return get_avg_market_rate() + ((get_max_market_rate() - get_avg_market_rate()) / 2.0)

func get_max_market_rate() -> float:
	return _market_buy_avg_rate * (1 + _delta_buy_rate)
	
