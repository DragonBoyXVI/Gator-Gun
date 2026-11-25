@tool
@abstract
extends Object;
class_name Consts;


enum Collision {
	## Walls soldiers cannot pass.
	SOLDIER_WALL = 1<<0,
	## Walls bullets cannot pass.
	BULLET_WALL = 1<<1,
};
static func _init_collision() -> void:
	const PATH := "layer_names/2d_physics/layer_%s";
	
	ProjectSettings.set_setting( PATH % 1, "Soldier Walls" );
	ProjectSettings.set_setting( PATH % 2, "Bullet Walls" );


static func _static_init() -> void:
	
	_init_collision();
