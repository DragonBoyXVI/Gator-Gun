@tool
extends SoldierState;
class_name SoldierStateFree;


const CAMERA_MAX_DIST := 256.0;


@export var _brain: Brain:
	set( new ):
		_brain = new;
		update_configuration_warnings();
@export var _movement: VelocityFloating2D:
	set( new ):
		_movement = new;
		update_configuration_warnings();
@export var _rotation: RotationControl:
	set( new ):
		_rotation = new;
		update_configuration_warnings();
@export var _model: Node2D:
	set( new ):
		_model = new;
		update_configuration_warnings();
@export var _camera_focus: Node2D:
	set( new ):
		_camera_focus = new;
		update_configuration_warnings();


func _get_configuration_warnings() -> PackedStringArray:
	var warnings := super();
	
	if ( not _brain ):
		warnings.append( "Please give this a reference to the soldiers brain!" );
	
	if ( not _movement ):
		warnings.append( "Please give this a reference to the soldiers movement component!" );
	
	if ( not _rotation ):
		warnings.append( "Please give this a reference to the soldiers rotation component!" );
	
	if ( not _model ):
		warnings.append( "Please give this a reference to the soldiers model!" );
	
	if ( not _camera_focus ):
		warnings.append( "Please give this a reference to a camera focus node!" );
	
	return warnings;

func _process( _delta: float ) -> void:
	
	_model.rotation = _rotation.get_current_rotation();
	
	if ( _brain.mouse_mode ):
		_camera_focus.global_position = _soldier.global_position.lerp( _soldier.get_global_mouse_position(), 0.5 );
	else:
		var vec := _brain.look_vector;
		if ( vec.is_zero_approx() ):
			vec = _brain.move_vector;
		_camera_focus.position = vec * CAMERA_MAX_DIST;

func _physics_process( delta: float ) -> void:
	
	_movement.accelerate_in_direction( delta, _brain.move_vector );
	_movement.move_character_body( _soldier );
	
	_rotation.rotate_to_direction( delta, _brain.look_vector.angle() );
