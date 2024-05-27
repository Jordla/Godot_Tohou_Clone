extends Area2D

@export var bullet_properties : BulletProperties

var frequency : float = 4.0
var amplitude : float = 25.0
var x : float = 0.0



func _physics_process(delta):
	# print(position.x)
	move_bullet(delta)
	#print("After move_bullet: " + var_to_str(position))
	move_bullet_sin(delta)
	#print("After sine_move: " + var_to_str(position))
	
	

func move_bullet(delta):
	position += transform.x * bullet_properties.bullet_speed * delta # What is transform.x
	

func move_bullet_deccelerate(delta):
	pass

func move_bullet_sin(delta):
	position += transform.y * ((sin(position.x * frequency * delta) * amplitude)) # Only works for x values only 
	#position += transform.x * bullet_properties.bullet_speed * delta # What is transform.x

func _on_visible_on_screen_notifier_2d_screen_exited():
	print("end")
	queue_free()
	
func change_frequency(value : float):
	frequency = value

func change_amplitude(value : float):
	amplitude = value
