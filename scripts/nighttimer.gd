extends Label

@export var seconds_per_hour: float = 30.0  # real-world seconds per in-game hour

const HOURS := [12, 1, 2, 3, 4, 5, 6]  # 12 AM -> 6 AM
var hour_index: int = 0

func _ready() -> void:
	$Timer.wait_time = seconds_per_hour
	hour_index = 0
	_update_label()

func _on_timer_timeout() -> void:
	hour_index += 1
	_update_label()
	if hour_index >= HOURS.size() - 1:  # just hit 6:00
		$Timer.stop()
		_survive_night()

func _update_label() -> void:
	text = "%d:00" % HOURS[hour_index]

func _survive_night() -> void:
	await get_tree().create_timer(1.5, true).timeout
	Global.complete_night(Global.currentNight)
	SceneTransition.fade_to_scene("res://scenes/night_complete_scene.tscn")
