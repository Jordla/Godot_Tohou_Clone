extends VBoxContainer
@onready var deceleration_slider = $DecelerationVbox/DecelerationSlider
@onready var ease_slider = $EaseVbox/EaseSlider
@onready var deceleration_value = $DecelerationVbox/HBoxContainer/DecelerationValue
@onready var ease_value = $EaseVbox/HBoxContainer/EaseValue


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_deceleration_slider_value_changed(value):
	deceleration_value.text = str(value)


func _on_ease_slider_value_changed(value):
	if value < -1.0:
		ease_value.text = str(value) + " (Ease in-out)"
	elif value == -1.0 or value == 1.0:
		ease_value.text = str(value) + " (Linear)"
	elif value > -1.0 or value < 0.0:
		ease_value.text = str(value) + " (Ease out-in)"
	elif value > 0.0 or value < 1.0:
		ease_value.text = str(value) + " (Ease out)"
	elif value == 0.0:
		ease_value.text = str(value) + " (No curve)"
	elif value > 1.0:
		ease_value.text = str(value) + " (Ease in)"
