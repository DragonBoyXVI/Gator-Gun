
extends Node2D;


@onready var _screen_fader_manager: ScreenFaderManager = $CanvasLayer/ScreenFaderManager;
@onready var _room_manager_2d: RoomManager2D = $RoomManager2D;


func _ready() -> void:
	
	Radio.add_sequence_requested.connect( _on_radio_add_sequence_requested, CONNECT_DEFERRED );
	
	_screen_fader_manager.fader_animation_finished.connect( Radio.update_screen_fader_state );
	_screen_fader_manager.set_fader_path( "res://DragonXVI-Godot/ScreenFaderSystem/obj_default_fade_to_black.tscn" );
	
	Radio.screen_fader_hide_screen_requested.connect( _on_radio_screen_fader_hide_screen_requested );
	Radio.screen_fader_show_screen_requested.connect( _on_radio_screen_fader_show_screen_requested );
	
	_room_manager_2d.room_changed.connect( Radio.emit_room_manager_changed_room );
	
	Radio.room_manager_change_room_requested.connect( _on_radio_room_manager_change_room_requested, CONNECT_DEFERRED );
	Radio.room_manager_set_pause_state_requested.connect( _on_radio_room_manager_set_pause_state_requested );


func _on_radio_add_sequence_requested( sequence_node: Node ) -> void:
	add_child( sequence_node );


func _on_radio_screen_fader_hide_screen_requested() -> void:
	_screen_fader_manager.hide_screen();

func _on_radio_screen_fader_show_screen_requested() -> void:
	_screen_fader_manager.show_screen();

func _on_radio_set_screen_fader_requested( screen_fader_path: String ) -> void:
	
	if ( !Cmd.has_arg( Cmd.DISABLED_THREADING ) ):
		_screen_fader_manager.set_fader_path_threaded( screen_fader_path );
	else:
		_screen_fader_manager.set_fader_path( screen_fader_path );


func _on_radio_room_manager_change_room_requested( room_path: String ) -> void:
	
	if ( !Cmd.has_arg( Cmd.DISABLED_THREADING ) ):
		_room_manager_2d.change_room_thread( room_path );
	else:
		_room_manager_2d.change_room( room_path );

func _on_radio_room_manager_set_pause_state_requested( paused: bool ):
	
	if ( paused ):
		_room_manager_2d.pause_rooms();
	else:
		_room_manager_2d.unpause_rooms();
