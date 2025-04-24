extends TextureRect

class_name ScalePlate
enum WEIGHT_ITEM_TYPE { BASE_WEIGHTS, BASE_ITEMS }

signal weight_changed(value : float)

@export var _marker_to_follow : Marker2D

@export_group("Container properties")
@export_range(1, 4, 1) var _max_colums_per_row : int = 3

@onready var _bottom_row_container : HBoxContainer = %ContainerBottomRow
@onready var _top_row_container : HBoxContainer = %ContainerTopRow

@onready var _anim_player : AnimationPlayer = %AnimationPlayer

var _items_in : Dictionary = {}
var _current_weight : int = 0.0
var _total_space_for_items : int = _max_colums_per_row * 2

func get_weight() -> int:
	return _current_weight

func _process(delta: float) -> void:
	if _marker_to_follow:
		global_position = _marker_to_follow.global_position - pivot_offset

func _get_used_item_space() -> int:
	var space_left_bottom = _bottom_row_container.get_child_count()
	var space_left_top = _top_row_container.get_child_count()
	return space_left_bottom + space_left_top

func _can_drop_data(_pos, data) -> bool:
	var data_node : Node = data as Node
	var node_id : int = data_node.get_instance_id()
	var is_already_in : bool = _items_in.has(node_id)
	var enough_space : bool = _total_space_for_items > _get_used_item_space()
	if is_already_in || !enough_space:
		return false
	if data is Weight || data is BaseItem:
		_anim_player.play("pulsate_hover")
		return true
	_anim_player.play("RESET")
	return false

func _drop_data(_pos, data):
	var dragged_data : Node = data as Node
	_current_weight += dragged_data.get_weight()
	_add_node_to_container(dragged_data)
	weight_changed.emit(_current_weight)
	
func _add_node_to_container(node : Node) -> void:
	if _bottom_row_container.get_child_count() < _max_colums_per_row:
		node.reparent(_bottom_row_container)
	elif _top_row_container.get_child_count() < _max_colums_per_row:
		node.reparent(_top_row_container)

func _on_box_container_child_entered_tree(node: Node) -> void:
	_items_in[node.get_instance_id()] = null

func _on_box_container_child_exiting_tree(node: Node) -> void:
	_anim_player.play("RESET")
	_items_in.erase(node.get_instance_id())
	if node is BaseItem || node is Weight:
		_current_weight -= node.get_weight()
		weight_changed.emit(_current_weight)

func _on_mouse_exited() -> void:
	_anim_player.play("RESET")
