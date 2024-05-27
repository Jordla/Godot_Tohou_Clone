extends Area2D

@onready var marker_2d = $Marker2D
@export var Bullet : PackedScene
@onready var enemy = $"."
@onready var line_2d = $Line2D

var wait_time = 1.0 # In msec
var time = 0.0

var rotated = 0.0

var fire = true

var temp_frequency = 0.0
var temp_amplitude = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.amplitude_changed.connect(changed_amplitude)
	Events.frequency_changed.connect(changed_frequency)
	Events.rotate_changed.connect(rotate_enemy)

func changed_amplitude(value):
	temp_amplitude = value

func changed_frequency(value):
	temp_frequency = value
	
func rotate_enemy():
	rotated += 10.0
	enemy.set_rotation_degrees(rotated)
	
func shoot():
	var b = Bullet.instantiate()
	b.frequency = temp_frequency
	b.amplitude = temp_amplitude
	b.transform = $Marker2D.global_transform
	get_tree().get_root().get_node("World").add_child(b)
	
	fire = false
	#timer.start()
	
#func _on_timer_timeout():
	#fire = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if time > wait_time:
		shoot()
		time = 0.0
	#rotate_enemy()





