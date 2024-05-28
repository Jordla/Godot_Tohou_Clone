extends Bullet

@onready var animation_player = $AnimationPlayer
var is_deccelerate : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("glow_1")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not is_deccelerate:
		velocity = get_velocity(delta)
		is_deccelerate = true
	position += velocity
	decelerate(delta)
	time += delta

func get_velocity(delta):
	return Vector2(get_x_velocity(delta), 0)
