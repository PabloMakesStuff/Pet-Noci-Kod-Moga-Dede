extends Label

const menu: PackedScene = preload("res://scenes/tittle.tscn")
var canSkip : bool = false

func _ready() -> void:
	$timer.connect("timeout", timerTimeout)
	$animation.connect("animation_finished", animDone)
	$animation.play("fade in")
	
func timerTimeout() -> void:
	$animation.play("fade out")

func animDone(animName : StringName) -> void:
	if animName == "fade in":
		canSkip = true
		$timer.start()
	if animName == "fade out":
		get_tree().change_scene_to_file("res://scenes/tittle.tscn")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("skip warning") and canSkip == true:
		## .play ima komandu za brzinu, stavio sam na 10 da bi brze proslo
		$animation.play("fade out",-1,10)
