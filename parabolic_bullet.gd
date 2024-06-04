extends Bullet

var coefficient_a : float = 6.0
var coefficient_b : float = 6.0
var constant_c : float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


	# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_velocity(delta)
	apply_rotation_transformation(velocity.x, velocity.y, get_rotation())
	position += velocity * delta
	super(delta)

func get_velocity(delta):
	velocity = Vector2(
			get_x_velocity(delta, is_decelerate), 
			pow((coefficient_a * time), 2) + coefficient_b * time + constant_c)
