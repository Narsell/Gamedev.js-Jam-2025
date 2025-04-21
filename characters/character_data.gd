extends Node

class_name CharacterData

var char_name : String = "NO_NAME"
var negotiator_type : BaseCharacter.NEGOTIATOR_TYPE = BaseCharacter.NEGOTIATOR_TYPE.AVERAGE
var rapport_floor : float = 0.0
var perc_to_increase_rapport : float = 0.1

func _init(in_name : String, in_neg_type : BaseCharacter.NEGOTIATOR_TYPE, in_rapp_floor : float = 0.0, in_perc_rapp : float = 0.1) -> void:
	char_name = in_name
	negotiator_type = in_neg_type
	rapport_floor = in_rapp_floor
	perc_to_increase_rapport = in_perc_rapp
