@tool
extends ObjRoom2D;
class_name ObjMainMenuRoom;


@export var _main_menu: ObjMainMenu;
@export var _profile_menu: ObjProfileMenu;


func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		return;
	
	_main_menu.play_pressed.connect( _on_main_menu_play_pressed );
	
	_profile_menu.back_pressed.connect( _on_profile_menu_back_pressed );
	
	_main_menu.focus_menu();


func _on_main_menu_play_pressed() -> void:
	
	_main_menu.release_focus();
	XVIControlAnimation.close_window( _main_menu );
	await XVIControlAnimation.open_window( _profile_menu ).finished;
	_profile_menu.focus_menu();

func _on_profile_menu_back_pressed() -> void:
	
	_profile_menu.release_focus();
	XVIControlAnimation.close_window( _profile_menu );
	await XVIControlAnimation.open_window( _main_menu ).finished;
	_main_menu.focus_menu();
