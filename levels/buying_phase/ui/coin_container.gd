extends HBoxContainer

class_name CoinContainer

@onready var _input: SpinBox = $Input
@export var _coin_type : GameState.MONEY_TYPE

var _money : Dictionary = {
	GameState.MONEY_TYPE.SILVER : 0,
	GameState.MONEY_TYPE.GOLD : 0
}

signal value_changed(value : float)

func _ready() -> void:
	_input.get_line_edit().max_length = 3
	if _coin_type == GameState.MONEY_TYPE.SILVER:
		_input.get_line_edit().max_length = 2
	
func get_coin_amount() -> int:
	var coin_value = _input.value
	if _coin_type == GameState.MONEY_TYPE.GOLD:
		coin_value *= 100
	return coin_value

func _on_input_value_changed(value: float) -> void:
	if value >= 100:
		_input.value = 99
