@tool
extends Node2D;
class_name Brain;
## Extends [Node2D] for mouse controls.
## This nodes global_position is used to determine what direction the mouse is in.
##
## Ditto


var move_vector: Vector2 = Vector2.ZERO;
var look_vector: Vector2 = Vector2.ZERO;


func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		
		XVIFuncs.set_node_processes( self, false );
		return;
