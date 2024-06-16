extends Area2D

class_name Bullet
@onready var sprite_2d = $Sprite2D


var time : float
var speed : float = 500.0
var velocity : Vector2
var deceleration : float
var ease_curve : float
var eased_value : float
var life_time: float = 1.0 
# Are checks for the button toggles
var is_decelerate : bool = false
var is_lifetime : bool = false
var is_explosive : bool = false

# Speed * transform to get velocity 
# Multiply by delta when added to position

func _physics_process(delta):
	time += delta
	check_lifetime()
	velocity_is_zero()


func get_x_velocity(delta, is_decelerate): # in the x direction
	var x_velocity = speed * (1 - eased_value) * delta
	if is_decelerate:
		eased()
	return x_velocity

func eased():
	eased_value = ease(time / life_time, ease_curve)

func velocity_is_zero():
	if eased_value == 1:
		queue_free()

func apply_rotation_transformation(x, y, theta):
	velocity.x = x * cos(theta) - (y * sin(theta))
	velocity.y = x * sin(theta) + (y * cos(theta))

func set_decelerate(status : bool):
	is_decelerate = status

func set_lifetime(status : bool):
	is_lifetime = status

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func check_lifetime():
	if is_lifetime and time > life_time:
		queue_free()

func _on_body_entered(body):
	queue_free()


func _on_tree_exited():
	if is_explosive:
		Events.explode.emit(transform, global_position)
