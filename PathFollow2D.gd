extends PathFollow2D
@onready var path_2d = $".."

var move_speed : float = 10.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if progress_ratio > 1:
		progress_ratio = 0
	# Move the object along the path
	progress_ratio += move_speed * delta * 0.02
	# Ensure the offset wraps around when it exceeds the path length
	
