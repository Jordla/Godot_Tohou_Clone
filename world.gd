extends Node2D

@onready var enemy = $Enemy
@onready var ui = $UI
#var ui = preload("res://ui.tscn")

var slider_frequency : float
var slider_amplitude : float
var slider_speed : float = 500.0
var slider_fire_rate : float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	ui.amplitude_changed.connect(set_amplitude)
	ui.frequency_changed.connect(set_frequency)
	ui.speed_changed.connect(set_speed)
	ui.fire_rate_changed.connect(set_fire_rate)
	enemy.shoot.connect(fire_bullet)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass

func set_amplitude(amplitude):
	slider_amplitude = amplitude

func set_frequency(frequncy):
	slider_frequency = frequncy

func set_speed(speed):
	slider_speed = speed

func set_fire_rate(fire_rate):
	enemy.wait_time = fire_rate

# Should create a bullet on enemy
func fire_bullet(Bullet : PackedScene, location : Transform2D):
	var bullet = Bullet.instantiate()
	bullet.transform = location
	add_child(bullet)
	if Events.current_bullet == "linear":
		bullet.speed = slider_speed
	elif Events.current_bullet == "sine":
		bullet.amplitude = slider_amplitude
		bullet.frequency = slider_frequency


	


