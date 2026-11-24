@tool
extends Node;


#region Sequence

## Emitted when a node needs to be added to the game world root.[br]
## [br]
## sequence_node: [Node] - The node we add to the game world.
signal add_sequence_requested( sequence_node: Node );
func request_add_sequence( sequence_node: Node ) -> void:
	add_sequence_requested.emit( sequence_node );

#endregion Sequence

#region Screen Fader

## Emitted when the screen hidden state changes. [br]
## [br]
## screen_hidden: [bool] - True if the screen is hidden, false if shown.
signal screen_fader_state_updated( screen_hidden: bool );
func update_screen_fader_state( screen_hidden: bool ) -> void:
	screen_fader_state_updated.emit( screen_hidden );

## Emitted when we want a new screen fader. [br]
## [br]
## screen_fader_path: [String] - Path/UID to the fader.
signal set_screen_fader_requested( screen_fader_path: String );
func request_set_screen_fader( screen_fader_path: String ) -> void:
	set_screen_fader_requested.emit( screen_fader_path );

## Emitted when we want to hide the screen. [br]
signal screen_fader_hide_screen_requested();
func request_screen_fader_hide_screen() -> void:
	screen_fader_hide_screen_requested.emit();

## Emitted when we want to show the screen. [br]
signal screen_fader_show_screen_requested();
func request_screen_fader_show_screen() -> void:
	screen_fader_show_screen_requested.emit();

#endregion Screen Fader

#region Room Manager

## Emitted when the room manager changes to a new room. [br]
## [br]
## room: [ObjRoom2D] - The room we changed to.
signal room_manager_changed_room( room: ObjRoom2D );
func emit_room_manager_changed_room( room: ObjRoom2D ) -> void:
	room_manager_changed_room.emit( room );

## Emitted when we want to change to a new room. [br]
## [br]
## room_path: [String] - Path/UID to the room.
signal room_manager_change_room_requested( room_path: String );
func request_room_manager_change_room( room_path: String ) -> void:
	room_manager_change_room_requested.emit( room_path );

## Emitted when we want to change the pause state of the current room. [br]
## [br]
## paused: [bool] - True to pause, false to unpause.
signal room_manager_set_pause_state_requested( paused: bool );
func request_room_manager_set_pause_state( paused: bool ):
	room_manager_set_pause_state_requested.emit( paused );

#endregion Room Manager
