extends Control

@onready var _supplier_position : Marker2D = %SupplierPosition

var _dialogue_res = preload("res://levels/buying_phase/buying_phase.dialogue")
var _current_char_node : BaseCharacter
var _currenting_offer : BaseItem

signal chit_chat_ended

func _get_next_supplier() -> BaseCharacter:
	var character_node : BaseCharacter
	while _current_char_node == character_node:
		character_node = GameState.get_random_character_node(GameState.NPC_TYPE.SUPPLIER)
	character_node.position = _supplier_position.position
	get_tree().current_scene.add_child(character_node)
	return character_node

func _ready() -> void:
	chit_chat_ended.connect(_on_chit_chat_ended)
	_current_char_node = _get_next_supplier()
	DialogueManager.show_dialogue_balloon(_dialogue_res, "start", [_current_char_node])
	
func _on_chit_chat_ended() -> void:
	_currenting_offer = _current_char_node.offer_random_item()
	
func _barter_for_item_offered(price : float) -> void:
	var offer : Offer = Offer.new()
	offer.item = _currenting_offer
	offer.offered_price = price
	var offer_result : OfferResult = _current_char_node.hear_offer(offer)
