extends CharacterBody2D


const SPEED: int = 300.0

var slow_mode: bool = false
		
func move_character():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down") # This is a vector 2D
	if slow_mode == true:
		velocity = (input_direction * SPEED) / 2
	else: 
		velocity = input_direction * SPEED

func is_slow_mode():
	if Input.is_action_pressed("slow_mode"):
		slow_mode = true
	else:
		slow_mode = false

func _physics_process(delta):
	is_slow_mode()
	move_character()
	move_and_slide()
