extends Node2D

@onready var ui = $UI
@onready var path_2d = $Path2D
@onready var enemy_movement_patterns = $UI/EnemyMovementPatterns
@onready var enemy = $Path2D/PathFollow2D/Enemy
@onready var new_bullet_factory = LinearBulletFactory.new()


#var ui = preload("res://ui.tscn")

var slider_frequency : float
var slider_amplitude : float
var slider_speed : float = 500.0
var slider_fire_rate : float = 1.0
var slider_a : float
var slider_b : float
var slider_c : float
var slider_ease_curve : float = 1.0
var spinner_lifetime : float
var is_deceleration_active : bool = false
var is_lifespan_active : bool = false
var slider_steer_force : float = 20.0
var is_trail_active : bool = false
var is_explosion_active : bool = false

@export var player_dummy : PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	ui.amplitude_changed.connect(set_amplitude)
	ui.frequency_changed.connect(set_frequency)
	ui.speed_changed.connect(set_speed)
	ui.fire_rate_changed.connect(set_fire_rate)
	ui.coefficient_a_changed.connect(set_a)
	ui.coefficient_b_changed.connect(set_b)
	ui.constant_c_changed.connect(set_c)
	ui.ease_curve_changed.connect(set_ease_curve)
	ui.lifespan_changed.connect(set_lifetime)
	ui.deceleration_toggled.connect(set_deceleration_state)
	ui.lifespan_toggled.connect(set_lifespan_state)
	ui.rotation_value_changed.connect(set_rotation_value)
	ui.steer_force_changed.connect(set_steer_force)
	ui.make_trail_toggled.connect(toggle_trail)
	ui.explode_toggled.connect(toggle_explosion)
	Events.fire.connect(fire_bullet)
	enemy_movement_patterns.path_selected.connect(set_path)
	Events.homing_bullet_selected.connect(spawn_player)
	Events.spawn_child.connect(spawn_child)
	Events.explode.connect(spawn_explosion)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#print(str(Events.player_instance))
	pass

func _process(delta):
	if Events.current_bullet != "homing" and Events.player_instance != null:
		get_node("DummyPlayer").queue_free()
	# Not homing and player not null
	# queue free player_instance

	# Homing selected, player_instance should be not null, select different bullet --> not homing but player_instance is still there --> queue_free() so that player_instance is null

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

func set_steer_force(value):
	slider_steer_force = value

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
	elif Events.current_bullet == "homing":
		bullet.home_onto(Events.player_instance)
		bullet.steer_force = slider_steer_force
		bullet.speed = slider_speed
	elif Events.current_bullet == "triangle":
		pass
	bullet.set_decelerate(is_deceleration_active)
	if is_deceleration_active:
		bullet.ease_curve = slider_ease_curve
	bullet.set_lifetime(is_lifespan_active)
	if is_lifespan_active:
		bullet.life_time = spinner_lifetime
	bullet.is_explosive = is_explosion_active
	add_child(bullet)
	if Events.current_bullet == "linear" and is_trail_active: # This check is temporary fix for making a bullet trail
		bullet.start_timer()

func set_path(path_str):
	path_2d.set_path(path_str)

func spawn_player(): # Maybe make a seperate button to spawn a player (toggled) - In the homing UI/ Save initial enemy positon
	# Set player positon to a global positon relative to enemy starting global position
	# Also code in a feature to reset enenmy positon back to original
	# Figure out global positon from marker2D or use marker 2D as placeholder positions to spawn from 
	var new_player = player_dummy.instantiate()
	new_player.global_position = Vector2(896.0, 320.0) # Need to figure out where to spawn player instance
	Events.player_instance = new_player
	add_child(new_player)
	# Add reference to singleton 

func toggle_trail(toggled_on):
	is_trail_active = toggled_on

# Want to handle child bullets similar to spawning parent bullets 
# Have each bullet emit the same signal 
# Call different constructor methods depending on the selected bullet
func spawn_child(bullet_transform, bullet_global_position):
	var new_bullet_child = new_bullet_factory.create_child(50, bullet_transform, bullet_global_position, true, 0.8, false, false)
	add_child(new_bullet_child)



func toggle_explosion(toggle_on):
	is_explosion_active = toggle_on
	
func spawn_explosion(bullet_transform, bullet_global_position):
	var counter = 0
	for num in range(12):
		var new_bullet_child = new_bullet_factory.create_child(400, bullet_transform, bullet_global_position, true, 4, false, false)
		new_bullet_child.transform = new_bullet_child.transform.rotated_local(counter)
		counter += PI/6
		add_child.call_deferred(new_bullet_child)
	

