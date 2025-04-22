extends TextureRect

@export var marker_to_follow : Marker2D

func _process(delta: float) -> void:
	
	global_position = marker_to_follow.global_position - pivot_offset
