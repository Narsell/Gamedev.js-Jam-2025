extends TextureRect

class_name ScalePlate

signal weight_changed(value : float)

@export var _marker_to_follow : Marker2D

@onready var _item_texture : TextureRect = %ItemTexture

var _current_weight : int = 0.0

func get_weight() -> int:
	return _current_weight

func _process(delta: float) -> void:
	if _marker_to_follow:
		global_position = _marker_to_follow.global_position - pivot_offset

func _can_drop_data(_pos, data) -> bool:
	return data is BaseItem
	
func _drop_data(_pos, data):
	var base_item : BaseItem = data as BaseItem
	_current_weight = base_item.get_weight()
	base_item.hide()
	_item_texture.texture = base_item.texture
	weight_changed.emit(20)
