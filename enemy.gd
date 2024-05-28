extends Area2D

@onready var marker_2d = $Marker2D
@export var LinearBullet : PackedScene
@export var SineBullet : PackedScene
@onready var enemy = $"."
@onready var line_2d = $Line2D

var wait_time = 1.0 # In msec
var time = 0.0

var rotated = 0.0

var fire = true

var current_bullet = null


signal shoot(Bullet : PackedScene, location : Transform2D)


# Called when the node enters the scene tree for the first time.
func _ready():
	current_bullet = LinearBullet
	Events.linear_bullet_selected.connect(select_linear)
	Events.sine_bullet_selected.connect(select_sine)
	Events.parabolic_bullet_selected.connect(select_parabolic)

func select_linear():
	current_bullet = LinearBullet

func select_sine():
	current_bullet = SineBullet
	
func select_parabolic():
	pass

func rotate_enemy():
	rotated += 10.0
	enemy.set_rotation_degrees(rotated)

func get_muzzle_position():
	return $Marker2D.global_transform


#func shoot():
	#var b = LinearBullet.instantiate()
	##b.frequency = temp_frequency
	##b.amplitude = temp_amplitude
	#b.transform = $Marker2D.global_transform
	#get_tree().get_root().get_node("World").add_child(b)
	#
	#fire = false
	##timer.start()
	
#func _on_timer_timeout():
	#fire = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	time += delta
	if time > wait_time:
		shoot.emit(current_bullet, get_muzzle_position())
		time = 0.0
	#rotate_enemy()





