extends CharacterBody2D


const SPEED = 300.0

		
func move_character():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down") # This is a vector 2D
	
	
	var slow_mode = false
	if Input.is_action_pressed("slow_mode"):
		slow_mode = true
		print(slow_mode)
		
		
	if slow_mode == true:
		velocity = (input_direction * SPEED) / 2
	else: 
		velocity = input_direction * SPEED
func _physics_process(delta):
	move_character()
	move_and_slide()
