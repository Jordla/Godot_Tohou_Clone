extends Bullet

var frequency : float = 4.0
var amplitude : float = 25.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func move_bullet_sin(delta):
	position += transform.y * ((sin(position.x * frequency * delta) * amplitude)) # Only works for x values only 
	#position += transform.x * bullet_properties.bullet_speed * delta # What is transform.x

func change_frequency(value : float):
	frequency = value

func change_amplitude(value : float):
	amplitude = value
