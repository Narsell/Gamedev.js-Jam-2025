extends CanvasLayer

@onready var sfx_bus_id = AudioServer.get_bus_index("sfx")
@onready var music_bus_id = AudioServer.get_bus_index("Music")
@onready var menu: Control = $CanvasLayer/Menu
@onready var settings: Control = %Settings
@onready var b_start: Button = %bStart
@onready var b_settings: Button = %bSettings
@onready var b_menu: Button = %bMenu
@onready var sfx_scroll_bar: HSlider = %SfxScrollBar
@onready var music_scroll_bar: HSlider = %MusicScrollBar

func _ready() -> void:
	music_scroll_bar.connect("value_changed", _on_music_scroll_bar_value_changed)
	sfx_scroll_bar.connect("value_changed", _on_sfx_scroll_bar_value_changed)
	b_start.connect("pressed", _on_start_pressed)
	b_settings.connect("pressed", _on_settings_pressed)
	b_menu.connect("pressed", _on_menu_pressed)
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_menu"):
		Engine.set_time_scale(0.0)
		print("pressed P")
		_on_settings_pressed()

func _on_start_pressed() -> void:
	#TODO: Start the game
	menu.visible = !menu.visible


func _on_settings_pressed() -> void:
	settings.visible = !settings.visible	

func _on_menu_pressed() -> void:
	menu.visible = true
	settings.visible = false

func _on_music_scroll_bar_value_changed(value: float) -> void:
	print("scroll value changed: {value}".format({"value": value}))
	AudioServer.set_bus_volume_linear(music_bus_id, value)
	AudioServer.set_bus_mute(music_bus_id, value < 0.05)


func _on_sfx_scroll_bar_value_changed(value: float) -> void:
	print("scroll value changed: {value}".format({"value": value}))
	AudioServer.set_bus_volume_linear(sfx_bus_id, value)
	AudioServer.set_bus_mute(sfx_bus_id, value < 0.05)
