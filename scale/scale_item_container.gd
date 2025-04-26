extends Panel

class_name ItemContainer

enum CONTAINER_TYPE { WEIGHTS, BASE_ITEMS }

@export var _supported_type : CONTAINER_TYPE = CONTAINER_TYPE.WEIGHTS

@onready var _grid_container : GridContainer = %GridContainer
@onready var _anim_player : AnimationPlayer = %AnimationPlayer

var _items_in : Dictionary = {}

func get_grid_container_node() -> GridContainer:
	return _grid_container
	
func add_child_to_container(node : Node) -> void:
	_grid_container.add_child(node)
	
func remove_children_from_container() -> void:
	for child in _grid_container.get_children():
		_grid_container.remove_child(child)

func _ready() -> void:
	for child in _grid_container.get_children():
		_on_grid_container_child_entered_tree(child)

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	var data_node : Node = data as Node
	var node_id : int = data_node.get_instance_id()
	var is_already_in : bool = _items_in.has(node_id)
	if is_already_in:
		return false
	match _supported_type:
		CONTAINER_TYPE.WEIGHTS:
			_anim_player.play("pulse")
			return data is Weight
		CONTAINER_TYPE.BASE_ITEMS:
			_anim_player.play("pulse")
			return data is BaseItem
	return false
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	_anim_player.play("RESET")
	var dragged_data : Node = data as Node
	dragged_data.reparent(_grid_container)

func _on_grid_container_child_entered_tree(node: Node) -> void:
	_items_in[node.get_instance_id()] = null

func _on_grid_container_child_exiting_tree(node: Node) -> void:
	_anim_player.play("RESET")
	_items_in.erase(node.get_instance_id())

func _on_mouse_exited() -> void:
	_anim_player.play("RESET")
