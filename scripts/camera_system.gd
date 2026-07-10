extends CanvasLayer

@onready var camera_feed: AnimatedSprite2D = $CameraFeed
@onready var camera_map_ui: Control = $CameraMapUI

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
