@tool
extends PanelContainer;
class_name ObjYesNoPanel;
## Simple abstracted yes or no interface.
##
## ditto


## User said no.
signal no_pressed();
## User said yes.
signal yes_pressed();


@export var _message_label: Label;
@export var _no_button: Button;
@export var _yes_button: Button;


func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		return;
	
	_no_button.pressed.connect( no_pressed.emit );
	_yes_button.pressed.connect( yes_pressed.emit );
	
	focus_entered.connect( _no_button.grab_focus, CONNECT_DEFERRED );


## Changes the question showed to the user.
func set_message_text( text: String ) -> void:
	_message_label.text = text;

## Changes the no button text.
func set_no_text( text: String ) -> void:
	_no_button.text = text;

## Changes the yes button text.
func set_yes_text( text: String ) -> void:
	_yes_button.text = text;
