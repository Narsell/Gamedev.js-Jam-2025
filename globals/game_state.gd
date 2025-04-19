extends Node

# This is to store player information that is supposed to persist between different scenes.

var mc_name : String = "Venuto"
var player_money : float = 0

var intro_was_honest : bool = false

func add_player_money(amount : int) -> void:
	player_money = clamp(player_money + amount, player_money, player_money + amount)
	print("Current money: ", player_money)
