extends CanvasLayer

@onready var fade: ColorRect = $Fade

func fade_to_scene(scene_path: String, duration: float = 0.5) -> void:
	fade.mouse_filter = Control.MOUSE_FILTER_STOP
	
	var tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)  # runs even when tree is paused
	tween.tween_property(fade, "modulate:a", 1.0, duration)
	await tween.finished
	
	get_tree().change_scene_to_file(scene_path)
	
	var tween_in = create_tween()
	tween_in.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween_in.tween_property(fade, "modulate:a", 0.0, duration)
	await tween_in.finished
	
	fade.mouse_filter = Control.MOUSE_FILTER_IGNORE
	get_tree().paused = false  # don't forget to unpause once you're done
