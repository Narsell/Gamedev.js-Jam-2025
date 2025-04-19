extends DialogueManager

var test_dialogue_res = preload("res://dialogue_system/dialogue_resources/test.dialogue")

func _ready() -> void:
	DialogueManager.show_dialogue_balloon(test_dialogue_res, "roll_a_dice");
