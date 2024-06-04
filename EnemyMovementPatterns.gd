extends VBoxContainer

@onready var option_button = $CenterContainer/OptionButton

signal path_selected(path_string)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_option_button_item_selected(index):
	var option = option_button.get_item_text(index)
	path_selected.emit(option)
	
	
