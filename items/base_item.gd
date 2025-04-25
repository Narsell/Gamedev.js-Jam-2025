extends TextureRect

class_name BaseItem

#region Types and Data

enum ITEM_TYPE { 
	VEGS_AND_FRUITS, PROTEIN, CHEESE,
	CLOVE, CINNAMON, GINGER,
	GOLD, BRONZE, EMERALD 
}
#endregion

@onready var _preview_drag_texture : TextureRect = null
@onready var picked_audio: AudioStreamPlayer = $PickedAudio
@onready var dropped_audio: AudioStreamPlayer = $DroppedAudio


@export_group("Basic Properties")
@export var item_type : ITEM_TYPE
@export_group("Market")
## Average price of this item in the market per pound. (middle point)
@export var _market_buy_avg_rate : float
## How much the min and max values can vary from the avg rate.
## This is floored to 0.4 to open up the range you can win or lose from haggling.
@export_range(0.4, 1.0, 0.1, "suffix:%") var _delta_buy_rate : float = 0.4

@export_group("Texture Selection")
@export var available_textures: Array[Texture2D] = []

static var max_possible_weight : int = 10.0
var _weight : int = 1.0

func _init() -> void:
	_weight = (randi() % max_possible_weight) + 1
	focus_mode = Control.FOCUS_CLICK
	
func _ready() -> void:
	connect("focus_entered", _on_focus_entered)
	if available_textures.size() <= 0:
		push_error("No textures assigned on %s" % self.name)
		return
	randomize()
	var random_index = randi() % available_textures.size()
	texture = available_textures[random_index]

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
	var preview = Control.new()
	var duplicated_node : BaseItem = self.duplicate()
	set_drag_preview(duplicated_node)
	duplicated_node.texture = texture
	duplicated_node._weight = _weight
	hide()
	return self
	
func _to_string() -> String:
	var str : String = ""
	str += ITEM_TYPE.keys()[item_type]
	str += "\n\tWeight: " + str(_weight)
	str += "\n\tAvg Price: " + str(_market_buy_avg_rate)
	str += "\n\tMin Price: " + str(get_min_market_rate())
	str += "\n\tMax Price: " + str(get_max_market_rate())
	return str 

func _input(event: InputEvent) -> void:
	# This is so the object is shown again when dropped after being dragged.
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
			if !event.pressed:
				dropped_audio.play()
				show()

func _on_focus_entered() -> void:
	picked_audio.play()
