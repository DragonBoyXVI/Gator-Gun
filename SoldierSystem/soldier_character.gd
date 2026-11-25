@tool
extends StrippedCharacterBody2D;
class_name ObjSoldierCharacter;


func _init() -> void:
	super();
	
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING;
	collision_mask = Consts.Collision.SOLDIER_WALL;
