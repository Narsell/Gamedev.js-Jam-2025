extends Control

@onready var rod : TextureRect = %Rod
@onready var plate_left : ScalePlate = $Plate_Left
@onready var plate_right : ScalePlate = $Plate_Right
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

@onready var _target_angle = rod.rotation
@onready var _current_angle = _target_angle

@export_range(0.0, 45.0, 0.5, "suffix:degs") var _max_angle : float = 35.0

func _rod_tween_finished() -> void:
	#print("Finished tween!")
	pass

func _calculate_rod_angle() -> void:
	var left_weight : float = plate_left.get_weight()
	var right_weight : float = plate_right.get_weight()
	var imbalance : float = (right_weight - left_weight) * (_max_angle / BaseItem.max_possible_weight)
	_target_angle = clamp(imbalance, -_max_angle, _max_angle)
	
	var tween = get_tree().create_tween()
	tween.tween_property(rod, "rotation", deg_to_rad(_target_angle), 2.0).set_trans(Tween.TRANS_SPRING)
	tween.tween_callback(_rod_tween_finished)

func _on_plate_left_weight_changed(value: float) -> void:
	audio_stream_player.play()
	_calculate_rod_angle()

func _on_plate_right_weight_changed(value: float) -> void:
	audio_stream_player.play()
	_calculate_rod_angle()
