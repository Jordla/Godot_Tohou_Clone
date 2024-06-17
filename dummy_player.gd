extends CharacterBody2D


const SPEED = 650.0
var movement_vector : Vector2

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	movement_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = movement_vector * SPEED

	move_and_slide()
