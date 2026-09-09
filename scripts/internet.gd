extends TextureButton

func _ready() -> void:
	$Label.text = str(Global.isInternetBroken)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.currentCamera == 'kitchen':
		$".".visible = true
	else:
		$".".visible = false


func _on_pressed() -> void:
	if Global.isInternetBroken == true:
		await SoundManager.play_sfx('internet_fixing',0.0,5.0)
		Global.isInternetBroken = false
		$Label.text = str(Global.isInternetBroken)
