extends Control

@onready var intro_character : BaseCharacter = %IntroCharacter

var docks_dialogue_res = preload("res://levels/docks/docks_dialogue.dialogue")

func _ready() -> void:
	DialogueManager.show_dialogue_balloon(docks_dialogue_res, "start", [intro_character]);
