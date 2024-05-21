extends CharacterBody2D

const SPEED: int = 300.0

var slow_mode: bool = false
var is_shooting: bool = false
var shoot_timer: float = 0.0

@export var Bullet: PackedScene
@onready var marker_2d = $Marker2D


		
func move_character():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down") # This is a vector 2D
	if slow_mode == true:
		velocity = (input_direction * SPEED) / 2
	else: 
		velocity = input_direction * SPEED

func is_slow_mode():
	if Input.is_action_pressed("slow_mode"):
		slow_mode = true
	else:
		slow_mode = false

func shoot():
	var bullet = Bullet.instantiate()
	add_child(bullet)
	bullet.transform = $Marker2D.transform
	
func _on_bullet_timer_timeout():
	shoot()
	
func _process(delta):
	if Input.is_action_pressed("shoot"):
		if is_shooting:
			shoot_timer += delta
			if shoot_timer > 0.04:
				shoot()
				shoot_timer = 0
		else:
			shoot()
			is_shooting = true
			shoot_timer = 0
	if Input.is_action_just_released("shoot"):
		is_shooting = false


func _physics_process(delta):
	is_slow_mode()
	move_character()
	move_and_slide()


