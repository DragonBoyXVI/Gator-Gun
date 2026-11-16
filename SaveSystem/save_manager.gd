@tool
extends Node;


signal profile_loaded( profile: Profile );


var current_profile: Profile:
	set( new ):
		
		current_profile = new;
		profile_loaded.emit( new );


func save_data() -> void:
	assert( current_profile );
	
	if ( !DirAccess.dir_exists_absolute( Profile.PROFILES_DIR_PATH ) ):
		DirAccess.make_dir_recursive_absolute( Profile.PROFILES_DIR_PATH );
	var file := FileAccess.open( Profile.PROFILES_DIR_PATH + "/" + current_profile.get_name_as_file(), FileAccess.WRITE );
	file.store_string( XVIFuncs.resource_to_json( current_profile ) );
	file.close();
	
	var profile_dir: String = Profile.PROFILES_DIR_PATH + "/" + current_profile.get_name_as_dir();
	if ( !DirAccess.dir_exists_absolute( profile_dir ) ):
		DirAccess.make_dir_recursive_absolute( profile_dir );
