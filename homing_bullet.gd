extends Bullet

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
	if first:
		velocity = Vector2(get_x_velocity(delta, is_decelerate), 0) # Get our velocity value
		first = false
	acceleration += seek() # Add Vector2 and prev acceleration to current acceleration
	velocity += acceleration * delta # Increase the velocity by the acceleration and multiply by delta to standardize into pixel units travelled
	velocity = velocity.limit_length(speed) # Cap the velocity 
	# angle() returns rotation in radians as a float, velocity is some 2D vector that has been rotated from (1,0)
	rotation = velocity.angle() # Rotate the bullet to match the velocity direction
	position += velocity * delta # Update the position of the bullet

func start(_transform, _target): # Called when you want to home onto a desired target
	global_transform = _transform # Set the position of the buller
	random_number = rng.randf_range(-0.09, 0.09)
	rotation += random_number # Adds slight rotation to bullet
	velocity = transform.x * speed # Move bullet
	target = _target # Keep reference of the target

func seek():
	var steer = Vector2.ZERO
	if target:
		var desired = (target.position - position).normalized() * speed
		steer = (desired - velocity)
	return steer
