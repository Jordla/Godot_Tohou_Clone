extends Bullet

var frequency : float = 4.0
var amplitude : float = 25.0
var time : float = 0.0
var velocity : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = get_velocity(delta)
	position += velocity
	time += delta

func get_velocity(delta):
	var y_velocity : float = cos(time * frequency) * amplitude * frequency
	var x_velocity : float = speed * delta
	return Vector2(x_velocity, y_velocity)
