extends Area2D

var bullet_speed: int = -1000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += transform.y * bullet_speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
