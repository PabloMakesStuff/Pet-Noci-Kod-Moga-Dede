extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(mouseEntered)
	if name == 'continue':
		visible = Global.highestNightUnlocked > 1  # nothing to continue yet

func mouseEntered() -> void:
	if ($"../arrow".position.y != position.y):
		$"../select change".play()
	$"../arrow".position.y = position.y

func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed('guiClick'):
		match name:
			'new game':
				Global.start_night(1)
			'continue':
				Global.start_night(Global.highestNightUnlocked)
