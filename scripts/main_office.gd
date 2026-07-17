extends Node2D

const CAMERA_SCENE: PackedScene = preload("res://scenes/camera_system.tscn")

var camera_instance: CanvasLayer = null
var camera_loading := false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("CameraFlip"):
		if camera_loading:
			return
		camera_loading = true
		_toggle_camera_action()
		camera_loading = false

func _toggle_camera_action() -> void:
	if camera_instance == null:
		camera_instance = CAMERA_SCENE.instantiate()
		add_child(camera_instance)  # CanvasLayer renders on top regardless of tree depth

	Global.camera_active = !Global.camera_active
	camera_instance.visible = Global.camera_active

	if Global.camera_active and camera_instance.has_method("reset_pan_state"):
		camera_instance.reset_pan_state()
