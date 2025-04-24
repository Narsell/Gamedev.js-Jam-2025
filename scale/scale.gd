extends Control

@onready var rod : TextureRect = %Rod
@onready var plate_left : ScalePlate = $Plate_Left
@onready var plate_right : ScalePlate = $Plate_Right

@onready var _target_angle = rod.rotation
@onready var _current_angle = _target_angle

func _rod_tween_finished() -> void:
	print("Finished tween!")

func _calculate_rod_angle() -> void:
	var left_weight : float = plate_left.get_weight()
	var right_weight : float = plate_right.get_weight()
	var imbalance : float = (right_weight - left_weight) * (35.0 / BaseItem.max_possible_weight)
	#map this imbalance to -35 to 35 degs
	print(imbalance)
	_target_angle = clamp(imbalance, -35.0, 35.0)
	
	var tween = get_tree().create_tween()
	tween.tween_property(rod, "rotation", deg_to_rad(_target_angle), 2.0).set_trans(Tween.TRANS_SPRING)
	tween.tween_callback(_rod_tween_finished)

func _on_plate_left_weight_changed(value: float) -> void:
	_calculate_rod_angle()

func _on_plate_right_weight_changed(value: float) -> void:
	_calculate_rod_angle()
