extends Node2D

# konstante i variable za kasnije
const CAMERA_SCENE_PATH := "res://scenes/camera_system.tscn"
var camera_instance: CanvasLayer = null
var camera_preload_started := false
var camera_loading := false

# cim se upali main_office zelimo da se ucitava camera system u pozadini
func _ready() -> void:
	_preload_camera_system()

# funkcija koja ucitava caamera system kada se upali office
func _preload_camera_system() -> void:
	if not camera_preload_started:
		camera_preload_started = true
		var err = ResourceLoader.load_threaded_request(CAMERA_SCENE_PATH)
		if err != OK:
			print("Failed to start loading camera scene: ", err)

# kada se klikne W pali se kamera sa camera_loading azuriranjem
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("CameraFlip"):
		if camera_loading:
			return
		camera_loading = true
		await Transition.fade_with_action(_toggle_camera_action)
		camera_loading = false

# igranje sa boolovima
func _toggle_camera_action() -> void:
	if camera_instance == null:
		await _instantiate_camera_system()

	Global.camera_active = !Global.camera_active
	if camera_instance:
		camera_instance.visible = Global.camera_active

# klenker optimizacija i thread zezanja
func _instantiate_camera_system() -> void:
	ResourceLoader.load_threaded_request(CAMERA_SCENE_PATH)
	while ResourceLoader.load_threaded_get_status(CAMERA_SCENE_PATH) == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		await get_tree().process_frame

	var camera_scene: PackedScene = ResourceLoader.load_threaded_get(CAMERA_SCENE_PATH)
	if camera_scene == null:
		return

	camera_instance = camera_scene.instantiate()
	get_tree().root.add_child(camera_instance)
