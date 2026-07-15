extends CanvasLayer

@onready var camera_feed: AnimatedSprite2D = $CameraFeed
@onready var camera_map_ui: Control = $CameraMapUI

@export var pan_speed: float = 200.0
@export var smoothing: float = 8.0
@export var pan_limit_left: float = -300.0  # le magic number
@export var pan_limit_right: float = 0.0  # le magic number 2

var target_offset: float = 0.0
var pan_direction: int = 0

func _ready() -> void:
	visible = false
	$"CameraMapUI/divided static".frame = 11

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

func show_camera(animation_name: String) -> void:
	$CameraMapUI/camSwitch.play()
	$"CameraMapUI/divided static".play("default")
	camera_feed.play(animation_name)
	camera_feed.visible = true

# untested code
func _on_texture_button_pressed() -> void:
	if $task_menu.visible == false:
		return
	if $task_menu.visible == true:
		pass

func _process(delta: float) -> void:
	if pan_direction != 0:
		target_offset += pan_direction * pan_speed * delta
		target_offset = clamp(target_offset, pan_limit_left, pan_limit_right)

	camera_feed.position.x = lerp(camera_feed.position.x, target_offset, smoothing * delta)

func _on_left_mouse_entered() -> void:
	pan_direction = 1

func _on_left_mouse_exited() -> void:
	if pan_direction == 1:
		pan_direction = 0

func _on_right_mouse_entered() -> void:
	pan_direction = -1

func _on_right_mouse_exited() -> void:
	if pan_direction == -1:
		pan_direction = 0
