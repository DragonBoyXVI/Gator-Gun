@tool
extends PanelContainer;
class_name ObjProfilePanel;
## A subpanel used in the [ObjProfileViewer] to display saved profiles.
##
## profile


signal load_pressed();
signal delete_pressed();


@export var _name_label: Label;
@export var _last_played_label: Label;
@export var _completion_label: Label;

@export var _load_button: Button;
@export var _delete_button: Button;


var _profile: Profile;


func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		return;
	
	focus_entered.connect( _load_button.grab_focus, CONNECT_DEFERRED );
	
	_load_button.pressed.connect( load_pressed.emit );
	_delete_button.pressed.connect( delete_pressed.emit );


func set_profile( profile: Profile ):
	
	_profile = profile;
	
	_name_label.text = profile.profile_name;
	_last_played_label.text = profile.date_last_played;
	_completion_label.text = profile.get_completion_percent_as_text();

func get_profile() -> Profile:
	return _profile;
