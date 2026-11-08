@tool
extends Node;
class_name RotationControl;


## How quickly this can rotate, in radians per second.
## Shown an degrees in the editor.
@export_range( 0.0, 720.0, 1.0, "or_greater", "radians_as_degrees" ) var rotation_speed: float = TAU;


var _current_rotation: float = 0.0;


## Returns the current rotation value.
func get_current_rotation() -> float:
	return _current_rotation;

## Snaps current rotation to a value.
func set_rotation( new_rotation: float ) -> void:
	_current_rotation = new_rotation;


## Returns the [@GlobalScope.angle_difference] of tge current direction and the provided direction.
func get_rotation_diffrence( direction: float ) -> float:
	return angle_difference( _current_rotation, direction );


## Adds the amount to the current rotation.
func rotate_by( amount: float ) -> void:
	_current_rotation += amount;


## Rotates the current direction to face a target direction.
func rotate_to_direction( delta: float, direction: float ) -> void:
	
	var rotate_delta: float = delta * rotation_speed;
	_current_rotation = rotate_toward( _current_rotation, direction, rotate_delta );
