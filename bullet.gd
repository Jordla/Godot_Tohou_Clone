extends Area2D
class_name Bullet
@onready var sprite_2d = $Sprite2D

var time : float = 0.0
var velocity : Vector2
var speed : float = 200

func _physics_process(delta):
	pass

func get_x_velocity(delta):
	return speed * delta

func get_y_velocity(delta):
	pass

func get_velocity(delta):
	pass

func move_bullet(delta):
	position += transform.x * speed * delta

func move_bullet_deccelerate(delta):
	pass

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	

