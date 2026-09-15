extends CanvasLayer
## Autoload as "SceneTransition".
## Call `await SceneTransition.fade_to_scene("res://scenes/whatever.tscn")`
## anywhere instead of get_tree().change_scene_to_file() to get a fade-to-black
## transition instead of a hard cut.

@onready var rect: ColorRect = $ColorRect

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	layer = 999  # draw above everything, including other CanvasLayers
	rect.color = Color.BLACK
	rect.modulate.a = 0.0
	rect.mouse_filter = Control.MOUSE_FILTER_IGNORE

func fade_to_scene(path: String, fade_out_time: float = 0.6, fade_in_time: float = 0.6) -> void:
	rect.mouse_filter = Control.MOUSE_FILTER_STOP  # block clicks while the screen is black

	var tween_out := create_tween()
	tween_out.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)  # keep fading even if the tree is paused
	tween_out.tween_property(rect, "modulate:a", 1.0, fade_out_time)
	await tween_out.finished

	get_tree().change_scene_to_file(path)
	await get_tree().process_frame  # let the new scene actually enter the tree first

	var tween_in := create_tween()
	tween_in.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween_in.tween_property(rect, "modulate:a", 0.0, fade_in_time)
	await tween_in.finished

	rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
