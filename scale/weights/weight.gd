extends TextureRect

class_name Weight

@onready var _lb_desc : RichTextLabel = %LbDesc
@onready var picked_audio: AudioStreamPlayer = $PickedAudio
@onready var dropped_audio: AudioStreamPlayer = $DroppedAudio

@export_range(1.0, 10.0, 1.0, "suffix:lb") var weight : int = 1.0

func get_weight() -> int:
	return weight

func _ready() -> void:
	focus_mode = Control.FOCUS_CLICK
	connect("focus_entered", _on_focus_entered)
	connect("focus_exited", _on_focus_exited)
	_lb_desc.text = str(weight) + " lb"
	_lb_desc.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
func _get_drag_data(at_position) -> Variant:
	var preview = Control.new()
	var duplicated_node : Node = self.duplicate()
	set_drag_preview(duplicated_node)
	hide()
	return self

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
			if !event.pressed:
				dropped_audio.play()
				show()

func _on_focus_entered() -> void:
	picked_audio.play()

func _on_focus_exited() -> void:
	dropped_audio.play()
