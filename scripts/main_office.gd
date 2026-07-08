extends Node2D

@onready var camera_map_ui: Control = $CameraMapUI
@onready var camera_system: AnimatedSprite2D = $CameraSystem

var camera_active: bool = false

func _ready() -> void:
	camera_map_ui.visible = false
	camera_system.visible = false

func _unhandled_input(event: InputEvent) -> void:
	print("input received: ", event)
	if event.is_action_pressed("CameraFlip"):
		#print("W pressed!")
		#Global.camera_active = !Global.camera_active
		#visible = Global.camera_active
		Global.camera_active = !Global.camera_active
		camera_map_ui.visible = Global.camera_active
		camera_system.visible = Global.camera_active
