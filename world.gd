extends Node2D

@onready var ui = $UI
@onready var path_2d = $Path2D
@onready var enemy_movement_patterns = $UI/EnemyMovementPatterns
@onready var enemy = $Path2D/PathFollow2D/Enemy

#var ui = preload("res://ui.tscn")

var slider_frequency : float
var slider_amplitude : float
var slider_speed : float = 500.0
var slider_fire_rate : float = 1.0
var slider_a : float
var slider_b : float
var slider_c : float
var slider_deceleration : float
var slider_ease_curve : float = 1.0
var spinner_lifetime : float
var is_deceleration_active : bool = false
var is_lifespan_active : bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	ui.amplitude_changed.connect(set_amplitude)
	ui.frequency_changed.connect(set_frequency)
	ui.speed_changed.connect(set_speed)
	ui.fire_rate_changed.connect(set_fire_rate)
	ui.coefficient_a_changed.connect(set_a)
	ui.coefficient_b_changed.connect(set_b)
	ui.constant_c_changed.connect(set_c)
	ui.deceleration_changed.connect(set_deceleration)
	ui.ease_curve_changed.connect(set_ease_curve)
	ui.lifespan_changed.connect(set_lifetime)
	ui.deceleration_toggled.connect(set_deceleration_state)
	ui.lifespan_toggled.connect(set_lifespan_state)
	ui.rotation_value_changed.connect(set_rotation_value)
	Events.fire.connect(fire_bullet)
	enemy_movement_patterns.path_selected.connect(set_path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass

func _input(event):
	if Input.is_action_just_pressed("bomb"):
		get_tree().call_group("Bullets", "queue_free")
	
func set_amplitude(amplitude):
	slider_amplitude = amplitude

func set_frequency(frequncy):
	slider_frequency = frequncy

func set_speed(speed):
	slider_speed = speed

func set_fire_rate(fire_rate):
	path_2d.enemy.wait_time = fire_rate

func set_a(a):
	slider_a = a

func set_b(b):
	slider_b = b

func set_c(c):
	slider_c = c

func set_deceleration(deceleration):
	slider_deceleration = deceleration

func set_ease_curve(ease_curve):
	slider_ease_curve = ease_curve

func set_lifetime(seconds):
	spinner_lifetime = seconds

func set_deceleration_state(toggled):
	is_deceleration_active = toggled

func set_lifespan_state(toggled):
	is_lifespan_active = toggled

func set_rotation_value(value):
	enemy.set_rotated(value)

# Create a bullet instance
func fire_bullet(Bullet : PackedScene, location : Transform2D):
	var bullet = Bullet.instantiate()
	bullet.transform = location
	if Events.current_bullet == "linear":
		bullet.speed = slider_speed
	elif Events.current_bullet == "sine":
		bullet.amplitude = slider_amplitude
		bullet.frequency = slider_frequency
	elif Events.current_bullet == "parabolic":
		bullet.coefficient_a = slider_a
		bullet.coefficient_b = slider_b
		bullet.constant_c = slider_c
	bullet.set_decelerate(is_deceleration_active)
	if is_deceleration_active:
		bullet.deceleration = slider_deceleration
		bullet.ease_curve = slider_ease_curve
	bullet.set_lifetime(is_lifespan_active)
	if is_lifespan_active:
		bullet.life_time = spinner_lifetime
	add_child(bullet)

func set_path(path_str):
	path_2d.set_path(path_str)

	


