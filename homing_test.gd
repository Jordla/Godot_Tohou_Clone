extends Node2D
@onready var dummy_player = $DummyPlayer
@onready var homing_bullet = $HomingBullet
@onready var marker_2d = $Marker2D
@onready var new_bullet_factory = LinearBulletFactory.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	homing_bullet.start(marker_2d.transform, dummy_player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var new_bullet = new_bullet_factory.create_child(400, marker_2d.transform, true, 1.0, false, false)
	add_child(new_bullet)
