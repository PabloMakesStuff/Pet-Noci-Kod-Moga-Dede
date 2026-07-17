extends CanvasLayer

@onready var camera_feed: AnimatedSprite2D = $CameraFeed
@onready var camera_map_ui: Control = $CameraMapUI
@export var pan_speed: float = 200.0
@export var smoothing: float = 8.0
@export var pan_limit_left: float = -300.0  # le magic number
@export var pan_limit_right: float = 0.0  # le magic number 2
var target_offset: float = 0.0
var pan_direction: int = 0
var base_camera_x: float = 10.0  # CameraFeed's actual authored resting x position

func _ready() -> void:
	visible = false
	_on_livingroom_pressed() #default kamera prvi put kad se udje
	base_camera_x = camera_feed.position.x  # capture real starting position, don't assume 0
	$"CameraMapUI/divided static".frame = 11

# Called from main_office._toggle_camera_action() every time the camera
# becomes visible, so leftover pan state from a previous session can't
# force an unexpected pan on reopen.
func reset_pan_state() -> void:
	target_offset = base_camera_x
	pan_direction = 0
	camera_feed.position.x = base_camera_x

func _on_bathroom_pressed() -> void:
	show_camera('bathroom')
func _on_hallway_pressed() -> void:
	show_camera('hallway')
func _on_kitchen_pressed() -> void:
	show_camera('kitchen')
func _on_livingroom_pressed() -> void:
	show_camera('livingroom')
func _on_room_1_pressed() -> void:
	show_camera('room1')
func _on_balcony_pressed() -> void:
	show_camera('balcony')

func show_camera(current_camera: String) -> void:
	Global.currentCamera = current_camera
	$CameraMapUI/camSwitch.play()
	$"CameraMapUI/divided static".play("default")
	$CameraFeed.updatecamera()

func _process(delta: float) -> void:
	if pan_direction != 0:
		target_offset += pan_direction * pan_speed * delta
		target_offset = clamp(target_offset, pan_limit_left, pan_limit_right)
	camera_feed.position.x = lerp(camera_feed.position.x, target_offset, smoothing * delta)

func _on_left_mouse_entered() -> void:
	print("left entered")
	pan_direction = 1
func _on_left_mouse_exited() -> void:
	print("left exited")
	if pan_direction == 1:
		pan_direction = 0
func _on_right_mouse_entered() -> void:
	print("right entered")
	pan_direction = -1
func _on_right_mouse_exited() -> void:
	print("right exited")
	if pan_direction == -1:
		pan_direction = 0
