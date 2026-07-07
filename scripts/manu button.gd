extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(mouseEntered)
	
func mouseEntered() -> void:
	if ($"../arrow".position.y != position.y):
		$"../select change".play()
	$"../arrow".position.y = position.y

func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed('guiClick'):
		if name == 'new game':
			get_tree().paused = true
			get_tree().change_scene_to_file("res://scenes/main_office.tscn")
