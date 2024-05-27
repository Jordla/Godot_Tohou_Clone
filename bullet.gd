extends Area2D
class_name Bullet


@export var bullet_properties : BulletProperties

func _physics_process(delta):
	# print(position.x)
	move_bullet(delta)
	#print("After move_bullet: " + var_to_str(position))
	#print("After sine_move: " + var_to_str(position))
	

func move_bullet(delta):
	position += transform.x * bullet_properties.bullet_speed * delta # What is transform.x
	

func move_bullet_deccelerate(delta):
	pass

func _on_visible_on_screen_notifier_2d_screen_exited():
	print("end")
	queue_free()
	

