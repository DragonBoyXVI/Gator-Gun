@tool
extends Control;
class_name ObjProfileDeletor;


signal profile_deleted();
signal delete_rejected();


@export var _name_label: Label;
@export var _last_played_label: Label;
@export var _completion_label: Label;

@export var _yes_no_panel: ObjYesNoPanel;


var _profile: Profile;


func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		return;
	
	_yes_no_panel.set_message_text( "KEY_DELETE_PROFILE_QUESTION" );
	
	_yes_no_panel.no_pressed.connect( _on_no_pressed );
	_yes_no_panel.yes_pressed.connect( _on_yes_pressed );
	
	focus_entered.connect( _yes_no_panel.grab_focus, CONNECT_DEFERRED );


func set_profile( profile: Profile ) -> void:
	_profile = profile;
	
	_name_label.text = profile.profile_name;
	_last_played_label.text = profile.date_last_played;
	_completion_label.text = profile.get_completion_percent_as_text();


func _on_no_pressed() -> void:
	delete_rejected.emit();

func _on_yes_pressed() -> void:
	if ( not _profile ):
		return;
	
	DirAccess.remove_absolute( Profile.PROFILES_DIR_PATH + "/" + _profile.get_name_as_file() );
	DirAccess.remove_absolute( Profile.PROFILES_DIR_PATH + "/" + _profile.get_name_as_dir() );
	
	profile_deleted.emit();
