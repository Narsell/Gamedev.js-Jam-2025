extends Control

@onready var _supplier_position : Control = %SupplierPosition
@onready var _item_container : ItemContainer = %ItemContainer

var _dialogue_intro = preload("res://levels/buying_phase/dialogue/buying_phase_intro.dialogue")
var _dialogue_offer_result = preload("res://levels/buying_phase/dialogue/buying_phase_offer_result.dialogue")
var _current_char_node : BaseCharacter
var _current_offer : BaseItem

signal chit_chat_ended
signal offer_response_ended

func _get_next_supplier() -> BaseCharacter:
	var new_character_node : BaseCharacter = GameState.get_random_character_node(GameState.NPC_TYPE.SUPPLIER)
	if _current_char_node != null:
		while _current_char_node.get_character_name() == new_character_node.get_character_name():
			new_character_node = GameState.get_random_character_node(GameState.NPC_TYPE.SUPPLIER)
		_supplier_position.remove_child(_current_char_node)
	_supplier_position.add_child(new_character_node)
	return new_character_node

func _start_interaction_with_current_char() -> void:
	_item_container.remove_children_from_container()
	_current_char_node = _get_next_supplier()
	if _current_char_node:
		DialogueManager.show_dialogue_balloon(_dialogue_intro, "start", [self, _current_char_node])
	else:
		printerr("No current character selected!")

func _ready() -> void:
	chit_chat_ended.connect(_on_chit_chat_ended)
	_start_interaction_with_current_char()
	
func _on_chit_chat_ended() -> void:
	_current_offer = _current_char_node.offer_random_item()
	_item_container.add_child_to_container(_current_offer)

func _barter_for_item_offered(price : float) -> void:
	var offer : Offer = Offer.new()
	offer.item = _current_offer
	offer.offered_price = price
	var offer_result : OfferResult = _current_char_node.hear_offer(offer)
	DialogueManager.show_dialogue_balloon(_dialogue_offer_result, "response_to_offer", [self, _current_char_node, offer_result])

func _on_offer_container_submit_offer(price: float) -> void:
	_barter_for_item_offered(price)

func _on_offer_response_ended() -> void:
	$AnimationPlayer.play("character_transition")
	
func _advance_to_next_character() -> void:
	_start_interaction_with_current_char()
