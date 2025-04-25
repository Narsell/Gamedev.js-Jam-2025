extends Control

@onready var intro_character : BaseCharacter = %Dagny
@onready var anim_player : AnimationPlayer = %AnimationPlayer

var docks_dialogue_res = preload("res://levels/docks/docks_dialogue.dialogue")

signal venuto_leaves_intro_shop

func _ready() -> void:
	var dialogueNode := DialogueManager.show_dialogue_balloon(docks_dialogue_res, "start", [self, intro_character]);
	venuto_leaves_intro_shop.connect(_on_venuto_leaves_intro_shop)
	AudioGlobal.current_place = "Docks"
	
func _on_venuto_leaves_intro_shop() -> void:
	anim_player.play("fade_in_transition")
	anim_player.animation_finished.connect(_on_anim_finished)
	
func _on_anim_finished(animation_name : StringName) -> void:
	if animation_name == "fade_in_transition":
		intro_character.hide()
		anim_player.play("fade_out_transition")
	elif animation_name == "fade_out_transition":
		DialogueManager.show_dialogue_balloon(docks_dialogue_res, "venuto_closing_lines", [intro_character]);
