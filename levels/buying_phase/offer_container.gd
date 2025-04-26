extends VBoxContainer

signal submit_offer(price : float)

@onready var submit_offer_button: Button = %SubmitOfferButton

@onready var silver_input: CoinContainer = %SilverInput
@onready var gold_input: CoinContainer = %GoldInput

func _on_submit_offer_button_pressed() -> void:
	var price_offer : int = silver_input.get_coin_amount() + gold_input.get_coin_amount()
	submit_offer.emit(price_offer)
