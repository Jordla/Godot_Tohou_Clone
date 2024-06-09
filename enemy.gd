extends Area2D
class_name Enemy

@onready var marker_2d = $Marker2D
@export var LinearBullet : PackedScene
@export var SineBullet : PackedScene
@export var ParabolicBullet : PackedScene
@export var HomingBullet : PackedScene
@export var TriangleBullet : PackedScene
@onready var enemy = $"."
@onready var line_2d = $Line2D

var wait_time : float = 1.0 # In msec
var time : float = 0.0
var rotate_value : float
var rotated : float
var current_bullet : PackedScene = null
var is_rotate : bool = false
var original_positon : Vector2


signal shoot(Bullet : PackedScene, location : Transform2D)


# Called when the node enters the scene tree for the first time.
func _ready():
	current_bullet = LinearBullet
	Events.linear_bullet_selected.connect(select_linear)
	Events.sine_bullet_selected.connect(select_sine)
	Events.parabolic_bullet_selected.connect(select_parabolic)
	Events.homing_bullet_selected.connect(select_homing)
	Events.triangle_bullet_selected.connect(select_triangle)
	Events.rotate_changed.connect(check_rotate)
	original_positon = global_position 

func select_linear():
	current_bullet = LinearBullet

func select_sine():
	current_bullet = SineBullet
	
func select_parabolic():
	current_bullet = ParabolicBullet

func select_homing():
	current_bullet = HomingBullet

func select_triangle():
	current_bullet = TriangleBullet

func set_rotated(value):
	rotate_value = value

func check_rotate(toggled_on):
	is_rotate = toggled_on

func get_muzzle_position():
	return $Marker2D.global_transform

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	time += delta
	if time > wait_time:
		#shoot.emit(current_bullet, get_muzzle_position())
		Events.fire.emit(current_bullet, get_muzzle_position())
		time = 0.0
	if is_rotate:
		rotated += rotate_value * Events.flipped
		enemy.set_rotation_degrees(rotated)




