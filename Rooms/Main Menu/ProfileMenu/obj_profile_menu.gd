@tool
extends Control;
class_name ObjProfileMenu;


@export var _profile_viewer: ObjProfileViewer;
@export var _profile_maker: ObjProfileMaker;

@export var _delete_profile_panel: Container;


func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		return;
	
	_profile_maker.created_profile.connect( _on_profile_maker_created_profile );
	
	_delete_profile_panel.hide();
	
	_profile_maker.grab_focus.call_deferred();


func _on_profile_maker_created_profile( profile: Profile )-> void:
	
	if ( not DirAccess.dir_exists_absolute( Profile.PROFILES_DIR_PATH ) ):
		DirAccess.make_dir_recursive_absolute( Profile.PROFILES_DIR_PATH );
	var file := FileAccess.open( Profile.PROFILES_DIR_PATH + "/" + profile.get_name_as_file(), FileAccess.WRITE );
	file.store_string( XVIFuncs.resource_to_json( profile ) );
	file.close();
	
	_profile_viewer.refresh.call_deferred();
