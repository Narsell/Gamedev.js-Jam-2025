extends Control

@onready var intro_character : BaseCharacter = %Dagny
@onready var anim_player : AnimationPlayer = %AnimationPlayer


var docks_dialogue_res = preload("res://levels/docks/docks_dialogue.dialogue")

signal venuto_leaves_intro_shop

func _ready() -> void:
	var dialogueNode := DialogueManager.show_dialogue_balloon(docks_dialogue_res, "start", [intro_character]);
	venuto_leaves_intro_shop.connect(_on_venuto_leaves_intro_shop)
	AudioGlobal.current_place = "Docks"
	
func _on_venuto_leaves_intro_shop() -> void:
	anim_player.play("fade_transition")
	anim_player.animation_finished.connect(_on_anim_finished)
	
func _on_anim_finished(animation_name : StringName) -> void:
	if intro_character.is_visible_in_tree():
		intro_character.hide()
		# TODO: Change assets around and move character?
		anim_player.play("fade_transition", -1, -1.0, true)
	else:
		DialogueManager.show_dialogue_balloon(docks_dialogue_res, "venuto_closing_lines", [intro_character]);
