extends TextureButton

func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.currentCamera == 'kitchen':
		$".".visible = true
	else:
		$".".visible = false


func _on_pressed() -> void:
	if Global.isInternetBroken == false:
		await $InternetFixSound.finished
		Global.isInternetBroken = true
		$Label.text = Global.isInternetBroken
