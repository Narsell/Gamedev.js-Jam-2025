extends TextureRect

class_name ScalePlate

enum WEIGHT_ITEM_TYPE { BASE_WEIGHTS, BASE_ITEMS }

signal weight_changed(value : float)

@export var _marker_to_follow : Marker2D

@onready var _item_container : BoxContainer = %BoxContainer

var _items_in : Dictionary = {}

var _current_weight : int = 0.0

func get_weight() -> int:
	return _current_weight

func _process(delta: float) -> void:
	if _marker_to_follow:
		global_position = _marker_to_follow.global_position - pivot_offset

func _can_drop_data(_pos, data) -> bool:
	var data_node : Node = data as Node
	var node_id : int = data_node.get_instance_id()
	var is_already_in : bool = _items_in.has(node_id)
	if is_already_in:
		return false
	return data is Weight || data is BaseItem

func _drop_data(_pos, data):
	var dragged_data : Node = data as Node
	_current_weight += dragged_data.get_weight()
	dragged_data.reparent(_item_container)

	weight_changed.emit(_current_weight)

func _on_box_container_child_entered_tree(node: Node) -> void:
	if node is BaseItem || node is Weight:
		_items_in[node.get_instance_id()] = null

func _on_box_container_child_exiting_tree(node: Node) -> void:
	if node is BaseItem || node is Weight:
		_items_in.erase(node.get_instance_id())
		_current_weight -= node.get_weight()
		weight_changed.emit(_current_weight)
