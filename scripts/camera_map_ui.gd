extends Control

@onready var camera_system: AnimatedSprite2D = $"../CameraSystem"

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
	$camSwitch.play()
	camera_system.play(animation_name)
	camera_system.visible = true
