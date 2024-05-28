extends CanvasLayer

@onready var linear_button = $BulletType/LinearButton
@onready var sine_button = $BulletType/SineButton
@onready var parabolic_button = $BulletType/ParabolicButton

@onready var linear_ui = $LinearUI
@onready var sine_ui = $SineUI
@onready var parabolic_ui = $ParabolicUI
var bullet_types : Array = []

signal amplitude_changed(amplitude)
signal frequency_changed(frequency)
signal speed_changed(speed)
signal fire_rate_changed(fire_rate)



# Called when the node enters the scene tree for the first time.
func _ready():
	linear_button.grab_focus()
	bullet_types = [linear_ui, sine_ui, parabolic_ui]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_amplitude_button_value_changed(value):
	Events.amplitude_changed.emit(value)


func _on_frequency_button_value_changed(value):
	Events.frequency_changed.emit(value)


func _on_rotate_button_pressed():
	Events.rotate_changed.emit()


func _on_linear_button_pressed():
	for bullet_type in bullet_types: 
		bullet_type.hide()
	linear_ui.show()
	Events.current_bullet = Events.bullet_array[0]
	Events.linear_bullet_selected.emit()
	
func _on_sine_button_pressed():
	for bullet_type in bullet_types: 
		bullet_type.hide()
	sine_ui.show()
	Events.current_bullet = Events.bullet_array[1]
	Events.sine_bullet_selected.emit()


func _on_parabolic_button_pressed():
	for bullet_type in bullet_types: 
		bullet_type.hide()
	parabolic_ui.show()
	Events.current_bullet = Events.bullet_array[2]
	Events.parabolic_bullet_selected.emit()

func _on_amplitude_slider_value_changed(value):
	amplitude_changed.emit(value)

func _on_frequency_slider_value_changed(value):
	frequency_changed.emit(value)

func _on_speed_slider_value_changed(value):
	speed_changed.emit(value)

func _on_fire_rate_slider_value_changed(value):
	fire_rate_changed.emit(value)
