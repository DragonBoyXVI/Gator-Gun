@tool
extends HapiticButton;
class_name GatorButton;


# focus anim: scale up slightly, tile to side mouse is on
# if in gamepad mode, tile toward center of screen
# XIf mouse comes from the top, tilt toward it
# otherwise, tilt away from it

# Xpress anim: scale down when pressed


const PRESS_TIME := 0.05;
const FOCUS_ANIM_TIME := 0.125;
const FOCUS_ROT_AMOUNT := deg_to_rad( 5.0 );
const CURVE_CENTER_PEAK := preload("uid://61uwihu5b8qa");


var _scale_tween: Tween;
var _rotation_tween: Tween;


func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		return;
	
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND;
	mouse_entered.connect( grab_focus, CONNECT_DEFERRED );



func _refresh_tween( tween: Tween ) -> Tween:
	
	if ( tween and tween.is_running() ):
		tween.kill();
	return create_tween();

func _is_bounce_on_right_side() -> bool:
	
	var my_center: Vector2 = get_global_rect().get_center();
	var mouse_position: Vector2 = get_global_mouse_position();
	
	if ( mouse_position.y > my_center.y ):
		return mouse_position.x < my_center.x;
	else:
		return mouse_position.x > my_center.x;


func _on_button_down() -> void:
	_scale_tween = _refresh_tween( _scale_tween );
	
	_scale_tween.tween_property( self, ^"offset_transform_scale", Vector2.ONE * 0.95, PRESS_TIME );

func _on_button_up() -> void:
	_scale_tween = _refresh_tween( _scale_tween );
	
	_scale_tween.tween_property( self, ^"offset_transform_scale", Vector2.ONE, PRESS_TIME );

func _on_focus_entered() -> void:
	_scale_tween = _refresh_tween( _scale_tween );
	
	_scale_tween.tween_property( self, ^"offset_transform_scale", Vector2.ONE * 1.05, FOCUS_ANIM_TIME );
	
	_rotation_tween = _refresh_tween( _rotation_tween );
	
	var bounce_to_right: bool = _is_bounce_on_right_side();
	var rotate_amount: float = FOCUS_ROT_AMOUNT if bounce_to_right else -FOCUS_ROT_AMOUNT;
	var tweener: PropertyTweener = _rotation_tween.tween_property( self, ^"offset_transform_rotation", rotate_amount, FOCUS_ANIM_TIME );
	tweener.set_ease( Tween.EASE_IN );
	tweener = _rotation_tween.tween_property( self, ^"offset_transform_rotation", 0.0, FOCUS_ANIM_TIME );
	tweener.set_ease( Tween.EASE_OUT );
	tweener.set_trans( Tween.TRANS_ELASTIC );

func _on_focus_exited() -> void:
	_scale_tween = _refresh_tween( _scale_tween );
	_scale_tween.set_ease( Tween.EASE_OUT );
	_scale_tween.set_trans( Tween.TRANS_BOUNCE );
	
	_scale_tween.tween_property( self, ^"offset_transform_scale", Vector2.ONE , FOCUS_ANIM_TIME );
