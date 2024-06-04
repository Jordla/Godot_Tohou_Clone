extends Bullet

var frequency : float = 4.0
var amplitude : float = 25.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_velocity(delta)
	apply_rotation_transformation(velocity.x, velocity.y, get_rotation())
	position += velocity
	super(delta)

func get_velocity(delta):
	velocity = Vector2(
			get_x_velocity(delta, is_decelerate), 
			cos(time * frequency) * amplitude * frequency)
