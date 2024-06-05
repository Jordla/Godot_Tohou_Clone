extends Node

signal linear_bullet_selected()
signal sine_bullet_selected()
signal parabolic_bullet_selected()
signal rotate_changed(toggled_on)
signal fire(current_bullet : PackedScene, position : Transform2D)

var bullet_array = ["linear", "sine", "parabolic"]
var current_bullet = bullet_array[0]
var flipped : int = 1
