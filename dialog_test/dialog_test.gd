extends DialogueManager

var test_dialogue_res = preload("res://dialogues/test.dialogue")

func _ready() -> void:
	print(test_dialogue_res)
	DialogueManager.show_dialogue_balloon(test_dialogue_res);
