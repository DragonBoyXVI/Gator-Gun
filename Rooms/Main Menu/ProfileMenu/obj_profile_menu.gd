@tool
extends Control;
class_name ObjProfileMenu;


@export var _profile_viewer: ObjProfileViewer;
@export var _profile_maker: ObjProfileMaker;
@export var _profile_deletor: ObjProfileDeletor;


func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		return;
	
	_profile_viewer.profile_delete_clicked.connect( _on_profile_viewer_profile_delete_clicked );
	_profile_viewer.profile_load_clicked.connect( _on_profile_viewer_profile_load_clicked );
	
	_profile_maker.created_profile.connect( _on_profile_maker_created_profile );
	_profile_maker.grab_focus.call_deferred();
	
	_profile_deletor.hide();
	_profile_deletor.delete_rejected.connect( _on_profile_deletor_delete_rejected );
	_profile_deletor.profile_deleted.connect( _on_profile_deletor_profile_deleted );


func _on_profile_maker_created_profile( profile: Profile )-> void:
	
	if ( not DirAccess.dir_exists_absolute( Profile.PROFILES_DIR_PATH ) ):
		DirAccess.make_dir_recursive_absolute( Profile.PROFILES_DIR_PATH );
	var file := FileAccess.open( Profile.PROFILES_DIR_PATH + "/" + profile.get_name_as_file(), FileAccess.WRITE );
	file.store_string( XVIFuncs.resource_to_json( profile ) );
	file.close();
	
	_profile_viewer.refresh.call_deferred();


func _on_profile_viewer_profile_load_clicked( _profile: Profile ) -> void:
	pass;

func _on_profile_viewer_profile_delete_clicked( profile: Profile ) -> void:
	
	_profile_deletor.set_profile( profile );
	release_focus();
	await XVIControlAnimation.open_window( _profile_deletor ).finished;
	_profile_deletor.grab_focus.call_deferred();


func _on_profile_deletor_delete_rejected() -> void:
	
	release_focus();
	await XVIControlAnimation.close_window( _profile_deletor ).finished;
	_profile_viewer.refresh();
	_profile_maker.grab_focus.call_deferred();

func _on_profile_deletor_profile_deleted() -> void:
	
	release_focus();
	await XVIControlAnimation.close_window( _profile_deletor ).finished;
	_profile_viewer.refresh();
	_profile_maker.grab_focus.call_deferred();
