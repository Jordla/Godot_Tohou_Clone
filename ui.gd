extends CanvasLayer



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_amplitude_button_value_changed(value):
	Events.amplitude_changed.emit(value)


func _on_frequency_button_value_changed(value):
	Events.frequency_changed.emit(value)


func _on_rotate_button_pressed():
	Events.rotate_changed.emit()
