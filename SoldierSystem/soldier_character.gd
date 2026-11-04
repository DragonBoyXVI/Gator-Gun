@tool
extends StrippedCharacterBody2D;
class_name SoldierCharacter;


func _init() -> void:
	super();
	
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING;
