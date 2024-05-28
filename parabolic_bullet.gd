extends Bullet

var coefficient_a : float = 6.0
var coefficient_b : float = 6.0
var constant_c : float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = get_velocity(delta)
	position += velocity
	time += delta

func get_velocity(delta):
	var velocity_y : float = pow((coefficient_a * time), 2) + coefficient_b * time + constant_c
	var velocity_x : float = get_x_velocity(delta)
	return Vector2(velocity_x, velocity_y)
