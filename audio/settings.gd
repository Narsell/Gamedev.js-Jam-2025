extends CanvasLayer

@onready var sfx_bus_id = AudioServer.get_bus_index("sfx")
@onready var music_bus_id = AudioServer.get_bus_index("Music")
@onready var settings: Control = %Settings

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("oper_menu"):
		settings.visible = !settings.visible		


func _on_music_scroll_bar_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(music_bus_id, value)
	AudioServer.set_bus_mute(music_bus_id, value < 0.05)


func _on_sfx_scroll_bar_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(sfx_bus_id, value)
	AudioServer.set_bus_mute(sfx_bus_id, value < 0.05)
