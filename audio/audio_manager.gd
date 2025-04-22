extends Node

@export var bg_music_player: AudioStreamPlayer
var current_place: String 


func _ready() -> void:
	current_place = AudioGlobal.current_place
	
	
func _process(delta: float) -> void:
	if current_place != AudioGlobal.current_place:
		current_place = AudioGlobal.current_place
		update_music_for_scene()
		

func update_music_for_scene():
	var current_place_music = str(current_place + "Music")
	bg_music_player["parameters/switch_to_clip"] = current_place_music
	
