extends Control

enum PHASES { INTRO, BUYING, SELLING }

var _current_phase : PHASES = PHASES.INTRO

@onready var _phase_scene : Dictionary = {
	PHASES.INTRO : preload("res://levels/docks/docks_start.tscn"),
	PHASES.BUYING : preload("res://levels/buying_phase/buying_phase.tscn"),
	#PHASES.SELLING : preload("res://levels/docks/selling_phase.tscn"),
}
@onready var _UI_canvas : CanvasLayer = %UI

func _ready() -> void:
	_on_phase_change(PHASES.INTRO)

func _on_phase_change(new_phase : PHASES) -> void:
	if new_phase == PHASES.INTRO:
		_UI_canvas.hide()
	if new_phase == PHASES.BUYING:
		_UI_canvas.show()
	if new_phase == PHASES.SELLING:
		_UI_canvas.show()
	call_deferred("_load_new_scene", _phase_scene[new_phase])
	_current_phase = new_phase
	
func _load_new_scene(packed_scene : PackedScene) -> void:
	get_tree().change_scene_to_packed(packed_scene)

#func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action_pressed("open_menu"):
		#print("pressed")
		#ui.visible = !ui.visible		
