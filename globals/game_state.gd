extends Node

# This is to store game state information that is supposed to persist between different scenes.

#region player

var mc_name : String = "Venuto"

enum MONEY_TYPE { SILVER, GOLD }
var player_money : Dictionary = {
	MONEY_TYPE.SILVER : 0,
	MONEY_TYPE.GOLD : 0
}

func add_player_money(amount : int, type : MONEY_TYPE) -> void:
	if amount <= 0: return
	if type == MONEY_TYPE.SILVER && player_money[type] + amount >= 100:
		var overflow_gold : int = 0
		var overflow_silver : int = 0
		overflow_gold = (player_money[type] + amount) / 100
		overflow_silver = player_money[type] + amount - (overflow_gold * 100)
		player_money[MONEY_TYPE.GOLD] += overflow_gold
		player_money[MONEY_TYPE.SILVER] += overflow_silver
	else:
		player_money[type] += amount
	print("Current money: \n\tSilver: " + str(player_money[MONEY_TYPE.SILVER]) + "\n\tGold: " + str(player_money[MONEY_TYPE.GOLD]))

func spend_player_money(amount : int, type : MONEY_TYPE) -> void:
	if amount >= 0: return
	if type == MONEY_TYPE.SILVER && player_money[type] + amount >= 100:
		var overflow_gold : int = 0
		var overflow_silver : int = 0
		overflow_gold = (player_money[type] + amount) / 100
		overflow_silver = player_money[type] + amount - (overflow_gold * 100)
		player_money[MONEY_TYPE.GOLD] -= overflow_gold
		player_money[MONEY_TYPE.SILVER] -= overflow_silver
	else:
		player_money[type] -= amount
	print("Current money: \n\tSilver: " + str(player_money[MONEY_TYPE.SILVER]) + "\n\tGold: " + str(player_money[MONEY_TYPE.GOLD]))

func did_player_run_out_of_money() -> bool:
	return player_money[MONEY_TYPE.SILVER] == 0 && player_money[MONEY_TYPE.GOLD] == 0

#endregion

#region characters
enum NPC_TYPE { SUPPLIER, VENDOR }

@onready var _supplier_characters : Array = [
	preload("res://characters/suppliers/baldwin.tscn"),
	preload("res://characters/suppliers/hayden.tscn")
]

@onready var _vendor_characters : Array = [
	preload("res://characters/vendors/dagny.tscn")
]

@onready var character_list : Dictionary = {
	NPC_TYPE.SUPPLIER : _supplier_characters,
	NPC_TYPE.VENDOR : _vendor_characters
}

var _character_data : Dictionary 
var intro_was_honest : bool = false

func are_there_valid_characters_left() -> bool:
	var valid_char_count : int = 0
	for char_key : CharacterData in _character_data.keys():
		var character_data : CharacterData = _character_data[char_key]
		if character_data.current_rapport > 0.0:
			++valid_char_count
	return valid_char_count > 0

func get_random_character_node(type : NPC_TYPE) -> BaseCharacter:
	var characters : Array = character_list[type]
	var char_scene : PackedScene =  characters.pick_random()
	var char_node : BaseCharacter = char_scene.instantiate()
	var char_name : String = char_node.get_character_name()
	if _character_data.has(char_name):
		char_node.update_character_with_new_data(_character_data[char_name])
	return char_node

func save_character_data(char_node : BaseCharacter) -> void:
	var char_name : String = char_node.get_character_name()
	_character_data[char_name] = char_node.get_data()
	if not _character_data.find_key(char_name):
		print("Saved new character data for character '" + char_name + "'")
#endregion

#region general game state

func check_for_game_lost() -> void:
	if did_player_run_out_of_money() && !are_there_valid_characters_left():
		get_tree().paused = true
		pass

#endregion
