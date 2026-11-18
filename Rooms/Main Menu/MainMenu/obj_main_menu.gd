@tool
extends Control;
class_name ObjMainMenu;


signal play_pressed();


@export var _buttons_container: Control;
@export var _play_button: Button;
@export var _quit_button: Button;


@export var _quit_confirm_yes_no_panel: ObjYesNoPanel;


func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		return;
	
	_play_button.pressed.connect( play_pressed.emit );
	
	_quit_button.pressed.connect( _on_quit_button_pressed );
	
	_quit_confirm_yes_no_panel.hide();
	_quit_confirm_yes_no_panel.yes_pressed.connect( get_tree().quit, CONNECT_DEFERRED );
	_quit_confirm_yes_no_panel.no_pressed.connect( _on_quit_confirm_yes_no_panel_no_pressed );


func focus_menu() -> void:
	_play_button.grab_focus.call_deferred();


func _on_quit_button_pressed() -> void:
	
	release_focus();
	XVIControlAnimation.close_window( _buttons_container );
	await XVIControlAnimation.open_window( _quit_confirm_yes_no_panel ).finished;
	_quit_confirm_yes_no_panel.grab_focus.call_deferred();

func _on_quit_confirm_yes_no_panel_no_pressed() -> void:
	
	release_focus();
	XVIControlAnimation.close_window( _quit_confirm_yes_no_panel );
	await XVIControlAnimation.open_window( _buttons_container ).finished;
	_play_button.grab_focus.call_deferred();
