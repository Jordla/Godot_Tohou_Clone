extends Bullet

class_name TriangleBullet

var amplitude : int = 12
var period : int = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	time = 1


func _physics_process(delta):
	get_velocity(delta)
	apply_rotation_transformation(velocity.x, velocity.y, get_rotation())
	position += velocity
	super(delta)

func get_velocity(delta):
	var part_a = (4 * amplitude) / period
	var part_b = int(time * 10 - period/4) % period
	var part_c = abs((part_b + period) % period - period/2)
	var part_d = abs(part_b - period/2)
	velocity = Vector2(
			get_x_velocity(delta, is_decelerate), 
			part_a * part_c - amplitude
)
