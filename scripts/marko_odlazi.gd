extends TextureButton

var sound = ['teranje1','teranje2','teranje3','teranje4']

func _on_pressed() -> void:
	if Global.markoRepelPressed == true:
		pass
	Global.markoRepelPressed = true
	await SoundManager.play_sfx(sound.pick_random())
	Global.markoRepelPressed = false
