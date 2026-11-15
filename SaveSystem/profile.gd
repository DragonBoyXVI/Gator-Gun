@tool
extends Resource;
class_name Profile;
## A profile lets seperate players have their own settings and game data, as well as achivements,
## unlocks, and just about anything tied to meta progression.
##
## balala


## Path to the directory that contains all saved profiles.
const PROFILES_DIR_PATH := "user://profiles/";


# profile storage system.,.
# all profiles in the profiles folder
# all profiles use their name to point to another folder with relivant game data


## The name used to represent this profile.
## Profile saver should throw an error if you try to make a profile with the same name, 
## most likely this is gonna be used for the folder?
@export_placeholder( "Drac Pelt..." ) var profile_name: String = "";
## Date the profile was created on.
@export_placeholder( "YYYY-MM-DD" ) var date_created: String = Time.get_date_string_from_system();
## Date the profile was last played on.
@export_placeholder( "YYYY-MM-DD" ) var date_last_played: String = Time.get_date_string_from_system();


## Returns a float from 0.0 to 1.0 based on how much content this profile has unlocked.
func get_completion_percent() -> float:
	return 0.0;

func get_name_as_file() -> String:
	return profile_name.replace( " ", "_" ) + ".json";
