extends CanvasLayer

@onready var linear_button = %LinearButton
@onready var sine_button = %SineButton
@onready var parabolic_button = %ParabolicButton

@onready var linear_ui = $LinearUI
@onready var sine_ui = $SineUI
@onready var parabolic_ui = $ParabolicUI

@onready var base_bullet_settings = $BaseBulletUI/BaseBulletSettings

@onready var speed_label_value = $LinearUI/SpeedVbox/LabelHbox/SpeedLabelValue
@onready var fire_rate_label_value = $LinearUI/FireRateVbox/LabelHbox/FireRateLabelValue
@onready var amplitdue_label_value = $SineUI/AmplitudeVbox/LabelHbox/AmplitdueLabelValue
@onready var frequency_label_value = $SineUI/FrequencyVbox/LabelHbox/FrequencyLabelValue



@onready var a_label_value = $ParabolicUI/CoeffAVbox/LabelHbox/ALabelValue
@onready var b_label_value = $ParabolicUI/CoeffBVbox/LabelHbox/BLabelValue
@onready var c_label_value = $ParabolicUI/ConstCVbox/LabelHbox/CLabelValue

@onready var rotation_value = $EnemyMovementPatterns/RotationLabels/RotationValue

@export var deceleration_ui : PackedScene
@export var lifespan_ui : PackedScene

var bullet_types : Array = []

signal amplitude_changed(amplitude)
signal frequency_changed(frequency)
signal speed_changed(speed)
signal fire_rate_changed(fire_rate)
signal coefficient_a_changed(a)
signal coefficient_b_changed(b)
signal constant_c_changed(c)
signal deceleration_changed(deceleration)
signal ease_curve_changed(ease_curve)
signal lifespan_changed(seconds)
signal deceleration_toggled(toggled)
signal lifespan_toggled(toggled)
signal rotation_value_changed(value)

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
	amplitdue_label_value.text = str(value)

func _on_frequency_slider_value_changed(value):
	frequency_changed.emit(value)
	frequency_label_value.text = str(value)

func _on_speed_slider_value_changed(value):
	speed_changed.emit(value)
	speed_label_value.text = str(value) + " px/sec"

func _on_fire_rate_slider_value_changed(value):
	fire_rate_changed.emit(value)
	fire_rate_label_value.text = str(value) + " sec"

func _on_coeff_a_slider_value_changed(value):
	coefficient_a_changed.emit(value)
	a_label_value.text = str(value)

func _on_coeff_b_slider_value_changed(value):
	coefficient_b_changed.emit(value)
	b_label_value.text = str(value)

func _on_const_c_slider_value_changed(value):
	constant_c_changed.emit(value)
	c_label_value.text	= str(value)

func _on_deceleration_slider_value_changed(value):
	deceleration_changed.emit(value)

func _on_ease_slider_value_changed(value):
	ease_curve_changed.emit(value)

func _on_lifespan_spin_box_value_changed(value):
	lifespan_changed.emit(value)

func _on_deceleration_button_toggled(toggled_on):
	if toggled_on:
		var deceleration_ui_instance = deceleration_ui.instantiate()
		base_bullet_settings.add_child(deceleration_ui_instance)
		deceleration_ui_instance.deceleration_slider.value_changed.connect(_on_deceleration_slider_value_changed)
		deceleration_ui_instance.ease_slider.value_changed.connect(_on_ease_slider_value_changed)
	elif not toggled_on:
		base_bullet_settings.get_node("DecelerationUI").queue_free()
	deceleration_toggled.emit(toggled_on)

func _on_lifespan_button_toggled(toggled_on):
	if toggled_on:
		var lifespan_ui_instance = lifespan_ui.instantiate()
		base_bullet_settings.add_child(lifespan_ui_instance)
		lifespan_ui_instance.lifespan_spin_box.value_changed.connect(_on_lifespan_spin_box_value_changed)
	elif not toggled_on:
		base_bullet_settings.get_node("LifespanUI").queue_free()
	lifespan_toggled.emit(toggled_on)

func _on_rotate_button_toggled(toggled_on):
	Events.rotate_changed.emit(toggled_on)

func _on_rotation_slider_value_changed(value):
	rotation_value_changed.emit(value)
	rotation_value.text = str(value)

func _on_flip_button_toggled(toggled_on):
	if toggled_on:
		Events.flipped = -1
	else:
		Events.flipped = 1
