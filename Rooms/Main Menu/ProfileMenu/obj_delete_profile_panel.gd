@tool
extends PanelContainer;
class_name ObjDeleteProfilePanel;


signal profile_deleted();
signal delete_rejected();


@export var _no_button: Button;
@export var _yes_button: Button;


var _profile: Profile;
