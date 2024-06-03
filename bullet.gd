extends Area2D
class_name Bullet
@onready var sprite_2d = $Sprite2D
@onready var lifespan_timer = $LifespanTimer


var time : float
var speed : float = 500.0
var velocity : Vector2
var deceleration : float
var ease_curve : float
var eased_value : float
var life_time: float = 1.0 
var is_decelerate : bool = false
var is_lifetime : bool = false

var decelerate_value : float = 0.0

func _physics_process(delta):
	pass

#func get_x_velocity(delta): # Returns a float
	#return speed * delta

func get_y_velocity(delta):
	pass

func get_x_velocity(delta): # in the x direction
	velocity.x = speed * (1 - eased_value) * delta

func move_bullet(delta):
	position += transform.x * speed * delta

func decelerate(delta): # Want deceleration value to move towards the current velocity
	velocity.x = move_toward(velocity.x, 0, delta * deceleration * eased_value)
	eased_value = ease(time / life_time, ease_curve) # Ease curve doesn't seem to work

func temp_decelerate(delta):
	#decelerate_value = move_toward(decelerate_value, speed * delta, deceleration * eased_value)
	if decelerate_value < deceleration:
		decelerate_value = (speed * delta) * eased_value
		eased_value = ease(time / life_time, ease_curve)

func eased():
	eased_value = ease(time / life_time, ease_curve)

func velocity_is_zero():
	if eased_value == 1:
		queue_free()

func update_time(delta):
	time += delta

#func set_lifetime(seconds : float):
	#if seconds > 0:
		#lifespan_timer.wait_time = seconds
		#lifespan_timer.start()
func set_decelerate(status : bool):
	is_decelerate = status

func set_lifetime(status : bool):
	is_lifetime = status

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_timer_timeout():
	queue_free()
