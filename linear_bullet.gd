extends Bullet

class_name LinearBullet

@onready var animation_player = $AnimationPlayer
@onready var spawn_timer = $SpawnTimer
@export var linear : PackedScene


var spawn_children : bool = false
var bullet_scale = scale
signal spawn_child

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("glow_1")
	if spawn_children == true:
		spawn_timer.start()
		print("started")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.x = get_x_velocity(delta, is_decelerate)
	position += transform.x * velocity.x
	super(delta)

func start_timer():
	spawn_timer.start()


func _on_spawn_timer_timeout():
	Events.spawn_child.emit(transform, global_position)
