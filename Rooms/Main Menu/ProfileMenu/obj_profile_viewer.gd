@tool
extends PanelContainer;
class_name ObjProfileViewer;
## Panel for viewing saved profiles.
##
## Ditt0


const OBJ_PROFILE_PANEL = preload("uid://5sc5wvqlhxkd");


signal profile_load_clicked( profile: Profile );
signal profile_delete_clicked( profile: Profile );


@export var _profile_panel_container: Container;


func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		return;
	
	_create_profile_panels();


func _delete_profile_panels() -> void:
	
	for child: Node in _profile_panel_container.get_children():
		
		if ( child is not ObjProfilePanel ):
			continue;
		
		child.queue_free();

func _create_profile_panels() -> void:
	
	if ( !DirAccess.dir_exists_absolute( Profile.PROFILES_DIR_PATH ) ):
		DirAccess.make_dir_recursive_absolute( Profile.PROFILES_DIR_PATH );
	var dir := DirAccess.open( Profile.PROFILES_DIR_PATH );
	
	var profiles_on_disk := dir.get_files();
	for profile_name: String in profiles_on_disk:
		
		var file := FileAccess.open( dir.get_current_dir() + "/" + profile_name, FileAccess.READ );
		var file_text: String = file.get_as_text();
		file.close();
		
		var profile := Profile.new();
		XVIFuncs.fill_resource_from_json( profile, file_text );
		
		var profile_panel: ObjProfilePanel = OBJ_PROFILE_PANEL.instantiate();
		profile_panel.set_profile( profile );
		_profile_panel_container.add_child( profile_panel );
		
		profile_panel.load_pressed.connect( profile_load_clicked.emit.bind( profile ) );
		profile_panel.delete_pressed.connect( profile_delete_clicked.emit.bind( profile ) );


func refresh() -> void:
	
	_delete_profile_panels();
	_create_profile_panels();
