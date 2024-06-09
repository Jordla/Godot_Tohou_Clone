extends Bullet

class_name HomingBullet

var acceleration = Vector2.ZERO
var steer_force = 50.0
var rng = RandomNumberGenerator.new()
var target = null
var first : bool = true
var random_number : float

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = 750.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if target != null:
		acceleration += seek() # Add Vector2 and prev acceleration to current acceleration
	velocity += acceleration * delta # Increase the velocity by the acceleration and multiply by delta to standardize into pixel units travelled
	velocity = velocity.limit_length(speed) # Cap the velocity 
	# angle() returns rotation in radians as a float, velocity is some 2D vector that has been rotated from (1,0)
	rotation = velocity.angle() # Rotate the bullet to match the velocity direction
	position += velocity * delta # Update the position of the bullet

# Do we need this function/Only needed for a toggleable homing feature
func start(_transform, _target): # Called when you want to home onto a desired target
	# COMMENT OUT/Don't need to toggle homing feature because it is a specific type of bullet 
	global_transform = _transform # Set the position of the buller
	random_number = rng.randf_range(-0.09, 0.09)
	rotation += random_number # Adds slight rotation to bullet
	velocity = transform.x * speed # Velocity is a vector2/x vector which is vector2(1, 0) * speed | Sets velocity value
	target = _target # Keep reference of the target

func home_onto(_target):
	#random_number = rng.randf_range(-0.09, 0.09)
	#rotation += random_number # Adds slight rotation to bullet
	velocity = transform.x * speed # Velocity is a vector2/x vector which is vector2(1, 0) * speed | Sets velocity value
	target = _target # Keep reference of the target

# We need the target reference
# We can get transform from enemy marker 2D
# Not sure about the rotation rng 
# We need to get initial velocity value without reseting velocity to speed * delta 
	# But delta value is returned only during runtime when _physics_process(delta) is called every physics tick
	# Maybe instead of velocity it's initial_velocity, doesn't address the reassignment of velocity if delta change

func seek():
	var steer = Vector2.ZERO
	if target:
		var desired = (target.position - position).normalized() * speed
		steer = (desired - velocity) * steer_force
	return steer
