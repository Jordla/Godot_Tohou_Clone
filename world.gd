extends Node2D

@onready var enemy = $Enemy
@onready var ui = $UI



# Called when the node enters the scene tree for the first time.
func _ready():
	#await get_tree().create_timer(5.0).timeout
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass
	
	
func change_amplitude(new_amplitude):
	enemy.b.amplitude = new_amplitude
	#print(new_amplitude)

func change_frequency(new_frequency):
	enemy.b.frequency = new_frequency
	#print(new_frequency)
	

