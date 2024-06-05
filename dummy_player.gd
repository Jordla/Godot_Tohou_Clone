extends CharacterBody2D


const SPEED = 500.0
var movement_vector : Vector2


func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	movement_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = movement_vector * SPEED

	move_and_slide()
