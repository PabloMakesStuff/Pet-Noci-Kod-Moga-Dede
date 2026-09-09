extends Node

var AI = {'marko':20,'aleksa':20,'djole':20}
var markoRepelPressed : bool = false
var DoorSceneOpened := false

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

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

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
