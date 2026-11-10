@tool
extends HapiticButton;
class_name GatorButton;


# focus anim: scale up slightly, tile to side mouse is on
# if in gamepad mode, tile toward center of screen

# press anim: scale down when pressed


var _tween: Tween;


func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		return;
	
	mouse_entered.connect( grab_focus, CONNECT_DEFERRED );


func _refresh_tween() -> void:
	
	if ( _tween and _tween.is_running() ):
		_tween.kill();
	_tween = create_tween();


func _on_button_down() -> void:
	_refresh_tween();
	
	const TIME := 0.25;
	
	_tween.tween_property( self, ^"offset_transform_scale", Vector2.ONE * 0.9, TIME );

func _on_button_up() -> void:
	_refresh_tween();
	
	const TIME := 0.25;
	
	_tween.tween_property( self, ^"offset_transform_scale", Vector2.ONE, TIME );

func _on_focus_entered() -> void:
	_refresh_tween();
	_tween.set_ease( Tween.EASE_OUT );
	_tween.set_trans( Tween.TRANS_ELASTIC );
	
	const TIME := 0.25;
	
	_tween.tween_property( self, ^"offset_transform_scale", Vector2.ONE * 1.05, TIME );

func _on_focus_exited() -> void:
	_refresh_tween();
	_tween.set_ease( Tween.EASE_OUT );
	_tween.set_trans( Tween.TRANS_BOUNCE );
	
	const TIME := 0.25;
	
	_tween.tween_property( self, ^"offset_transform_scale", Vector2.ONE , TIME );
