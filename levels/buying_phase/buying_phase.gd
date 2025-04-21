extends Control

@onready var _supplier_position : Marker2D = %SupplierPosition
var _current_char_node : BaseCharacter

func _get_next_supplier() -> BaseCharacter:
	var character_node : BaseCharacter = GameState.get_random_character_node(GameState.NPC_TYPE.SUPPLIER)
	character_node.position = _supplier_position.position
	get_tree().current_scene.add_child(character_node)
	return character_node

func _ready() -> void:
	var _current_char_node = _get_next_supplier()
