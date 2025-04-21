extends Sprite2D
class_name BaseCharacter

#region Types and Data
enum NEGOTIATOR_TYPE { SUCKER, NAIVE, AVERAGE, TOUGH, HARD }
#endregion


@export_group("Character Traits")
@export var _char_name : String = "NO_NAME"
@export var _negotiator_type : NEGOTIATOR_TYPE = NEGOTIATOR_TYPE.AVERAGE
@export_range(0, 1, 0.1) var _rapport_floor : float = 0
## How good an offer needs to be over the acceptable price in order to increase rapport.
@export_range(0, 0.3, 0.1) var _percent_to_increase_rapport : float = 0.1

var _current_rapport : float = _rapport_floor
var _data : CharacterData

func _init() -> void:
	_data = CharacterData.new(_char_name, _negotiator_type, _rapport_floor, _percent_to_increase_rapport)

func update_data(char_data : CharacterData) -> void:
	_data = char_data
	_char_name = char_data.name
	_negotiator_type = char_data.negotiator_type
	_rapport_floor = char_data.rapport_floor
	_percent_to_increase_rapport = char_data.perc_to_increase_rapport
	
func _exit_tree() -> void:
	GameState.save_character_data(self)

func get_character_name() -> String:
	return _char_name
	
func get_data() -> CharacterData:
	return _data

func lower_rapport() -> void:
	var rapport_decrement := 0.1
	if _negotiator_type == NEGOTIATOR_TYPE.HARD:
		rapport_decrement = 0.2
	_current_rapport = clampf(_current_rapport - rapport_decrement, _rapport_floor, 1.0)
	
func increase_rapport(amount : float = 0.1) -> void:
	var rapport_increment := amount
	if _negotiator_type == NEGOTIATOR_TYPE.SUCKER:
		rapport_increment = 0.2
	_current_rapport = clampf(_current_rapport + rapport_increment, _rapport_floor, 1.0)
	print(_char_name + ": Increased rapport to " + str(_current_rapport))

func _get_acceptable_price(item : BaseItem) -> float:
	var low_middle := item.get_low_middle_point_market_rate()
	var high_middle := item.get_high_middle_point_market_rate()
	# TODO: Multiply by rapport level (0 to 1) to get a btter price the better the rapport and the opposite the worse the rapport 
	if _negotiator_type >= NEGOTIATOR_TYPE.TOUGH:
		return item.get_avg_market_rate() + ((high_middle - item.get_avg_market_rate()) / 2.0)
	elif _negotiator_type == NEGOTIATOR_TYPE.AVERAGE:
		return low_middle + ((item.get_avg_market_rate() - low_middle) / 2.0)
	elif _negotiator_type <= NEGOTIATOR_TYPE.NAIVE:
		return item.get_min_market_rate() + ((low_middle - item.get_min_market_rate()) / 2.0)
		
	printerr("This shouldn't happen, negotiator type is not mapped!")
	return 0.0
	
func _calculate_counter_offer(item : BaseItem) -> CounterOffer:
	var counter_offer : CounterOffer = CounterOffer.new(0.0)
	if _negotiator_type >= NEGOTIATOR_TYPE.TOUGH:
		counter_offer.price = item.get_high_middle_point_market_rate()
		lower_rapport()
	elif _negotiator_type == NEGOTIATOR_TYPE.AVERAGE:
		counter_offer.price = _get_acceptable_price(item)
	elif _negotiator_type <= NEGOTIATOR_TYPE.NAIVE:
		counter_offer.price = item.get_low_middle_point_market_rate()
	return counter_offer
	
func hear_offer(offer: Offer) -> OfferResult:
	var acceptable_price : float =  _get_acceptable_price(offer.item)
	var offer_result : OfferResult = OfferResult.new()
	
	if offer.offered_price < acceptable_price:
		offer_result.response = OfferResult.RESPONSE.NO_DEAL
		offer_result.counter_offer = _calculate_counter_offer(offer.item)
	else:
		var possitive_diff: = acceptable_price - offer.offered_price
		if possitive_diff > _percent_to_increase_rapport or _negotiator_type <= NEGOTIATOR_TYPE.NAIVE:
			offer_result.DEAL
			increase_rapport()
			
	# Rapport reached 0, this character is mad as fuck.
	if is_equal_approx(_current_rapport, 0.0):
		offer_result.response = OfferResult.RESPONSE.FUCK_YOU
		
	return offer_result
