@tool
extends PanelContainer;
class_name ObjProfileMaker;
## Object used for making a new player profile.
##
## Emits the created profile as a signal.
## TODO: make this not create profiles if that profile name already exists.


const TEST_FILE := Profile.PROFILES_DIR_PATH + "secrettest.json";
const ERR_TEXT_INVALID_CHARS = "KEY_PROFILE_INVALID_NAME";
const ERR_TEXT_PROFILE_EXISTS = "KEY_PROFILE_ALREADY_EXISTS";


static func get_valid_text( text: String ) -> String:
	
	var valid_text := "";
	var regex := RegEx.create_from_string( "[A-Za-z0-9 ]" );
	for valid_char: RegExMatch in regex.search_all( text ):
		valid_text += valid_char.get_string();
	
	if ( valid_text[ 0 ] == " " ):
		valid_text[ 0 ] = "";
	
	return valid_text;


## Emitted when this creates a profile.
signal created_profile( new_profile: Profile );


@export var _error_label: Label;
@export var _line_edit: LineEdit;
@export var _submit_button: Button;


func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		return;
	
	_error_label.hide();
	_submit_button.disabled = true;
	
	focus_entered.connect( _submit_button.grab_focus, CONNECT_DEFERRED );
	
	_line_edit.text_changed.connect( _on_line_edit_text_changed );
	_submit_button.pressed.connect( _on_submit_button_pressed );


func _make_profile() -> void:
	
	var profile := Profile.new();
	profile.profile_name = _line_edit.text;
	profile.date_created = Time.get_date_string_from_system();
	profile.date_last_played = profile.date_created;
	
	created_profile.emit( profile );


func _on_line_edit_text_changed( text: String ) -> void:
	
	# reject empty
	if ( text.is_empty() ):
		
		_submit_button.disabled = true;
		_error_label.hide();
		return;
	
	# reject invalid chars
	var valid_text := get_valid_text( text );
	var is_text_valid: bool = valid_text.length() == text.length();
	
	if ( !is_text_valid ):
		
		_submit_button.disabled = true;
		_error_label.show();
		_error_label.text = ERR_TEXT_INVALID_CHARS;
		return;
	
	# reject existing profiles
	if ( not DirAccess.dir_exists_absolute( Profile.PROFILES_DIR_PATH ) ):
		DirAccess.make_dir_recursive_absolute( Profile.PROFILES_DIR_PATH );
	var dir := DirAccess.open( Profile.PROFILES_DIR_PATH );
	if ( dir.file_exists( text + ".json" ) ):
		
		_submit_button.disabled = true;
		_error_label.show();
		_error_label.text = ERR_TEXT_PROFILE_EXISTS;
		return;
	
	#valid
	_submit_button.disabled = false;
	_error_label.hide();

func _on_submit_button_pressed() -> void:
	
	var valid_text := get_valid_text( _line_edit.text );
	
	if ( !valid_text.is_empty() ):
		_make_profile();
		_submit_button.disabled = true;
