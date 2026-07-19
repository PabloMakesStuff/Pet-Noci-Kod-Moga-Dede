extends TextureButton

func _on_pressed() -> void:
	Global.markoRepelPressed = true
	$AudioStreamPlayer2D.play()
	await $AudioStreamPlayer2D.finished
	Global.markoRepelPressed = false
