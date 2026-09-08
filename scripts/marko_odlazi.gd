extends TextureButton

func _on_pressed() -> void:
	Global.markoRepelPressed = true
	SoundManager.play_sfx('')
	Global.markoRepelPressed = false
