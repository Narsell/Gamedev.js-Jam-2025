extends Control

@export var intro_character : BaseCharacter

var docks_dialogue_res = preload("res://levels/docks/docks_dialogue.dialogue")

func _ready() -> void:
	DialogueManager.show_dialogue_balloon(docks_dialogue_res);
