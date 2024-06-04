extends Path2D
@onready var path_follow_2d = $PathFollow2D
@export var horizontal_path : Curve2D
@export var vertical_path : Curve2D
@export var circular_path : Curve2D
@export var still_path : Curve2D
@onready var enemy = $PathFollow2D/Enemy

var speed = 300
var current_curve : Curve2D

func _on_ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	curve = current_curve
	path_follow_2d.progress += speed * delta

func set_path(path_str):
	match path_str:
		"Still":
			current_curve = still_path
		"Horizontal":
			current_curve = horizontal_path
		"Vertical":
			current_curve = vertical_path
		"Circular":
			current_curve = circular_path
