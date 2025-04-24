extends TextureRect

class_name BaseItem

#region Types and Data

enum ITEM_TYPE { 
	VEGS_AND_FRUITS, MEAT, CLOTHING,
	CLOVE, CINNAMON, GINGER,
	GOLD, BRONZE, EMERALD 
}
#endregion

@onready var _preview_drag_texture : TextureRect = null

@export_group("Basic Properties")
@export var item_type : ITEM_TYPE
@export_group("Market")
## Average price of this item in the market. (middle point)
@export var _market_buy_avg_rate : float
## How much the min and max values can vary from the avg rate.
## This is floored to 0.4 to open up the range you can win or lose from haggling.
@export_range(0.4, 1.0, 0.1, "suffix:%") var _delta_buy_rate : float = 0.4

static var max_possible_weight : int = 10.0
var _weight : int = 1.0

func _init() -> void:
	_weight = (randi() % max_possible_weight) + 1
	print(self)

func get_weight() -> int:
	return _weight

func get_min_market_rate() -> float:
	return (_market_buy_avg_rate * (1 - _delta_buy_rate))

func get_low_middle_point_market_rate() -> float:
	return get_min_market_rate() + ((get_avg_market_rate() - get_min_market_rate()) / 2.0)

func get_avg_market_rate() -> float:
	return (_market_buy_avg_rate)

func get_high_middle_point_market_rate() -> float:
	return (get_avg_market_rate() + ((get_max_market_rate() - get_avg_market_rate()) / 2.0))

func get_max_market_rate() -> float:
	return (_market_buy_avg_rate * (1 + _delta_buy_rate))

func _get_drag_data(at_position) -> Variant:
	_preview_drag_texture = TextureRect.new()
	_preview_drag_texture.texture = texture
	_preview_drag_texture.expand_mode = 1
	_preview_drag_texture.size = texture.get_size()
	var preview = Control.new()
	preview.add_child(_preview_drag_texture)
	set_drag_preview(preview)
	
	return self
	
func _to_string() -> String:
	var str : String = ""
	str += ITEM_TYPE.keys()[item_type]
	str += "\n\tWeight " + str(_weight)
	str += "\n\tAvg Price " + str(_market_buy_avg_rate)
	str += "\n\tMin Price " + str(get_min_market_rate())
	str += "\n\tMax Price" + str(get_max_market_rate())
	return str 
	
