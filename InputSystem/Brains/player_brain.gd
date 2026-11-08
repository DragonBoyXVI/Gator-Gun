@tool
extends Brain;
class_name PlayerBrain;
## Brain for player control.
##
## touch me >=3


func _process( _delta: float ) -> void:
	
	shoulder_left = Input.is_action_pressed( InputNames.Shoulder.LEFT );
	shoulder_right = Input.is_action_pressed( InputNames.Shoulder.RIGHT );
	
	accept = Input.is_action_pressed( InputNames.ACCEPT );
	back = Input.is_action_pressed( InputNames.BACK );
	special = Input.is_action_pressed( InputNames.SPECIAL );
	
	move_vector = InputNames.Move.get_vector();
	
	if ( mouse_mode ):
		look_vector = global_position.direction_to( get_global_mouse_position() );
	else:
		var test_me: Vector2 = InputNames.Look.get_vector();
		
		if ( !test_me.is_zero_approx() ):
			look_vector = test_me;
			return;
		
		if ( !move_vector.is_zero_approx() ):
			look_vector = move_vector;
			return;

func _unhandled_input( event: InputEvent ) -> void:
	if ( event.is_echo() ): return;
	
	if ( event is InputEventMouseMotion ):
		
		mouse_mode = true;
		
		get_viewport().set_input_as_handled();
		return;
	
	if (
		event.is_action( InputNames.Look.RIGHT ) or
		event.is_action( InputNames.Look.DOWN ) or
		event.is_action( InputNames.Look.LEFT ) or
		event.is_action( InputNames.Look.UP ) 
		):
			
			mouse_mode = false;
			
			get_viewport().set_input_as_handled();
			return;
