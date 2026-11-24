@tool
extends Node;
class_name ChangeRoomSequence;
## Pauses rooms, fades out the screen, changes the room to the target room,
## fades the screen back in, unpauses rooms.


var target_room_path: String = "";


func _ready() -> void:
	
	Radio.request_room_manager_set_pause_state( true );
	
	Radio.request_screen_fader_hide_screen();
	await Radio.screen_fader_state_updated;
	
	Radio.request_room_manager_change_room( target_room_path );
	if ( !Cmd.has_arg( Cmd.DISABLED_THREADING ) ):
		await Radio.room_manager_changed_room;
	
	Radio.request_screen_fader_show_screen();
	await Radio.screen_fader_state_updated;
	
	Radio.request_room_manager_set_pause_state( false );
	
	queue_free();
