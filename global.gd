extends Node

var AI = {'marko':20,'aleksa':1,'djole':1}
var markoRepelPressed : bool = false
var DoorSceneOpened := false
signal jumpscare_requested(which: String)

var aleksaPosition : String = 'bathroom_1'
var djolePosition : String = 'livingroom_1'
var markoPosition : String = 'livingroom_1'

var isInternetBroken: bool = true
var currentCamera : String = ''
var isDoorClosed : bool = false
var office_pan : float = 0.0
@export var isOnDoorSprite: bool
var camera_active: bool = false

var aleksaChargePercent: float = 100.0

# --- Nights / save data ---
const SAVE_PATH := "user://save.dat"

var currentNight: int = 1
var highestNightUnlocked: int = 1  # 1 = nothing beaten yet

# Tune these however you like — one entry per night.
const NIGHT_CONFIGS := {
	1: {'marko': 1, 'aleksa': 1, 'djole': 1},
	2: {'marko': 3, 'aleksa': 2, 'djole': 2},
	3: {'marko': 6, 'aleksa': 3, 'djole': 4},
	4: {'marko': 10, 'aleksa': 5, 'djole': 6},
	5: {'marko': 20, 'aleksa': 8, 'djole': 10},
}

func save_progress() -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_var(highestNightUnlocked)
		file.close()

func load_progress() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
		if file:
			highestNightUnlocked = file.get_var()
			file.close()

## Sets up Global state for `night` and loads main_office. Call this from
## the title screen (New Game / Continue) instead of change_scene_to_file directly.
func start_night(night: int) -> void:
	currentNight = night
	AI = NIGHT_CONFIGS.get(night, NIGHT_CONFIGS[1]).duplicate()

	# reset per-run state so a fresh night doesn't inherit the last run's mess
	markoPosition = 'livingroom_1'
	djolePosition = 'livingroom_1'
	aleksaPosition = 'bathroom_1'
	isInternetBroken = false
	isDoorClosed = false
	aleksaChargePercent = 100.0
	markoRepelPressed = false
	DoorSceneOpened = false
	camera_active = false
	currentCamera = ''
	office_pan = 0.0

	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_office.tscn")

## Call this once you have a "survived until 6 AM" condition somewhere.
## It unlocks the next night and writes the save file.
func complete_night(night: int) -> void:
	if night >= highestNightUnlocked:
		highestNightUnlocked = night + 1
		save_progress()

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	load_progress()

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed:
			if event.keycode == KEY_ESCAPE:
				get_tree().quit()
			if event.keycode == KEY_F11:
				if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
					DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
					DisplayServer.window_set_size(Vector2i(1152, 648))
					DisplayServer.window_set_position(Vector2i(int((DisplayServer.screen_get_size().x/2.0)-(DisplayServer.window_get_size().x/2.0)),int((DisplayServer.screen_get_size().y/2.0)-(DisplayServer.window_get_size().y/2.0))))
				else:
					DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
