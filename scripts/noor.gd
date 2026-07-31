extends AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.DoorSceneOpened = true
	if Global.isDoorClosed == true:
		$".".frame = 1
	else:
		$".".frame = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	if Global.isDoorClosed == false:
		$".".frame = 1
		Global.isDoorClosed = true

	else:
		$".".frame = 0
		Global.isDoorClosed = false
