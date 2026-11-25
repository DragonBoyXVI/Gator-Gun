@tool
@abstract
extends State;
class_name SoldierState;
## Base class for all soldier states.
##
## wawawawario


@export var _soldier: ObjSoldierCharacter:
	set( new ):
		_soldier = new;
		update_configuration_warnings();


func _get_configuration_warnings() -> PackedStringArray:
	var warnings := PackedStringArray();
	
	if ( not _soldier ):
		warnings.append( "Please give this a reference to the soldier!" );
	
	return warnings;
