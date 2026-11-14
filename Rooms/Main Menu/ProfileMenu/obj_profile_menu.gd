@tool
extends Control;
class_name ObjProfileMenu;

@export var _profile_viewer: ObjProfileViewer;
@export var _profile_maker: ObjProfileMaker;



func _on_profile_maker_created_profile( profile: Profile )-> void:
	pass;
