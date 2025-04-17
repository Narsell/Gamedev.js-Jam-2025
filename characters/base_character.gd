extends Control

enum NEGOTIATOR_TYPE {  NAIVE, SUCKER, AVERAGE, HARD, TOUGH }
var _acceptable_price_factor : Dictionary = {
	NEGOTIATOR_TYPE.HARD:		1.2,
	NEGOTIATOR_TYPE.TOUGH:		1.0,
	NEGOTIATOR_TYPE.AVERAGE:	0.9,
	NEGOTIATOR_TYPE.NAIVE:		0.8,
	NEGOTIATOR_TYPE.SUCKER:		0.6
}

@export_group("Character Traits")
@export var char_name : String = "NO_NAME"
@export var negotiator_type : NEGOTIATOR_TYPE = NEGOTIATOR_TYPE.AVERAGE
@export_range(0, 1, 0.1) var rapport_floor : float = 0
@export_range(0, 0.3, 0.1) var percent_to_increase_rapport : float = 0.1

func hear_offer(offer: Offer) -> OfferResult:
	var acceptable_price : float =  offer.item.market_buy_avg_rate * _acceptable_price_factor[NEGOTIATOR_TYPE] 
	var offer_result : OfferResult = OfferResult.new()
	var counter_offer : CounterOffer = CounterOffer.new(0.0)
	if offer.offered_price < acceptable_price:
		offer_result.response = OfferResult.RESPONSE.NO_DEAL
		counter_offer.counter_price = offer.item.marget_buy_max_rate
		# Decrease rapport
	else:
		var possitive_diff: = acceptable_price - offer.offered_price
		if possitive_diff > percent_to_increase_rapport or negotiator_type <= NEGOTIATOR_TYPE.NAIVE:
			offer_result.DEAL
			# Increase rapport
	return offer_result
	
 
