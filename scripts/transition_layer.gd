extends CanvasLayer

@onready var fade: ColorRect = $Fade

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func fade_to_scene(scene_path: String, duration: float = 0.28) -> void:
	await _fade_out(duration)

	ResourceLoader.load_threaded_request(scene_path)
	while ResourceLoader.load_threaded_get_status(scene_path) == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		await get_tree().process_frame

	var new_scene = ResourceLoader.load_threaded_get(scene_path)
	get_tree().change_scene_to_packed(new_scene)
	get_tree().paused = false

	await _fade_in(duration)

# generic version: runs fade out -> your custom callable -> fade in
func fade_with_action(action: Callable, duration: float = 0.3) -> void:
	await _fade_out(duration)
	await action.call()
	await _fade_in(duration)

func _fade_out(duration: float) -> void:
	fade.mouse_filter = Control.MOUSE_FILTER_STOP
	var tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(fade, "modulate:a", 1.0, duration)
	await tween.finished

func _fade_in(duration: float) -> void:
	var tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(fade, "modulate:a", 0.0, duration)
	await tween.finished
	fade.mouse_filter = Control.MOUSE_FILTER_IGNORE
