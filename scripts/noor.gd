extends AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.DoorSceneOpened = true
	if Global.isDoorClosed == true:
		$".".frame = 1
	else:
		$".".frame = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Global.isDoorClosed:
		if $".".animation != "Prazno_zat":
			$".".play("Prazno_zat")
	else:
		if Global.djolePosition == "hallway":
			if $".".animation != "Djole":
				$".".play("Djole")
		elif Global.markoPosition == "hallway":
			if $".".animation != "Marko":
				$".".play("Marko")
		else:
			if $".".animation != "Prazno_ot":
				$".".play("Prazno_ot")

func _on_button_pressed() -> void:
	if Global.isDoorClosed == true:
		SoundManager.play_sfx('door_close')
	else:
		SoundManager.play_sfx('door_open')
	Global.isDoorClosed = not Global.isDoorClosed
