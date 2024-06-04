extends Area2D
class_name Enemy

@onready var marker_2d = $Marker2D
@export var LinearBullet : PackedScene
@export var SineBullet : PackedScene
@export var ParabolicBullet : PackedScene
@onready var enemy = $"."
@onready var line_2d = $Line2D

var wait_time : float = 1.0 # In msec
var time : float = 0.0
var rotated : float = 0.0
var current_bullet : PackedScene = null
var is_rotate : bool = false


signal shoot(Bullet : PackedScene, location : Transform2D)


# Called when the node enters the scene tree for the first time.
func _ready():
	current_bullet = LinearBullet
	Events.linear_bullet_selected.connect(select_linear)
	Events.sine_bullet_selected.connect(select_sine)
	Events.parabolic_bullet_selected.connect(select_parabolic)
	Events.rotate_changed.connect(check_rotate)

func select_linear():
	current_bullet = LinearBullet

func select_sine():
	current_bullet = SineBullet
	
func select_parabolic():
	current_bullet = ParabolicBullet

func rotate_enemy():
	rotated += 10.0
	enemy.set_rotation_degrees(rotated)

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
		rotate_enemy()





