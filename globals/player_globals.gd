extends Node

# This is to store player information that is supposed to persist between different scenes.

var mc_name : String = "Venuto"
var money : float = 0

func add_money(amount : int) -> void:
	clamp(money + amount, money, money + amount)
