extends Control

class_name BaseItem

enum ITEM_CATEGORY { COMMON, SPICES, ORES }

enum ITEM_TYPE { 
	VEGS_AND_FRUITS, MEAT, CLOTHING,
	CLOVE, CINNAMON, GINGER,
	GOLD, BRONZE, EMERALD 
}

var AVAILABLE_ITEMS : Dictionary = {
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

@export var category : ITEM_CATEGORY
@export var item_type : ITEM_TYPE
@export var market_buy_min_rate : float = 0.0
@export var market_buy_avg_rate : float = 0.0
@export var market_buy_max_rate : float = 0.0
