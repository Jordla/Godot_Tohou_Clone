extends CharacterBody2D


const SPEED = 300.0

func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down") # This is a vector 2D
	velocity = input_direction * SPEED

func _physics_process(delta):
	get_input()
	move_and_slide()
