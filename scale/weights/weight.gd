extends TextureRect

class_name Weight

@onready var _lb_desc : RichTextLabel = %LbDesc

@export_range(1.0, 10.0, 1.0, "suffix:lb") var weight : int = 1.0

func get_weight() -> int:
	return weight

func _ready() -> void:
	_lb_desc.text = str(weight) + " lb"
	_lb_desc.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
func _get_drag_data(at_position) -> Variant:
	var preview = Control.new()
	var duplicated_node : Node = self.duplicate()
	set_drag_preview(duplicated_node)
	return self
