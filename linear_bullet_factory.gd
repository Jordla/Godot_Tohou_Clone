extends Node

class_name LinearBulletFactory
var linear = preload("res://linear_bullet.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create_child(_speed, _transform, _global_position, _is_lifetime, _life_time, _spawn_children, _is_explosive) -> LinearBullet:
	var linear_child = linear.instantiate()
	linear_child.speed = _speed
	linear_child.transform = _transform # Want to offset bullet position so that it the children do not spawn immediately ontop of parent bullet
	linear_child.scale = Vector2(0.6, 0.6)
	linear_child.position = _global_position + Vector2(-20, 0)
	linear_child.is_lifetime = _is_lifetime
	linear_child.life_time = _life_time
	linear_child.spawn_children = _spawn_children
	linear_child.is_explosive = _is_explosive
	return linear_child
