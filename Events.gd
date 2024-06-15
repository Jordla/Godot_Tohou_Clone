extends Node

signal linear_bullet_selected()
signal sine_bullet_selected()
signal parabolic_bullet_selected()
signal homing_bullet_selected
signal triangle_bullet_selected
signal rotate_changed(toggled_on)
signal fire(current_bullet : PackedScene, position : Transform2D)

signal spawn_child(_transform, _global_position)
signal explode(_transform, _global_position)

var bullet_array = ["linear", "sine", "parabolic", "homing", "triangle"]
var current_bullet = bullet_array[0]
var flipped : int = 1
var player_instance : Node
