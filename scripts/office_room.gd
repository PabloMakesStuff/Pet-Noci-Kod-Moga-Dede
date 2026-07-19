extends Sprite2D

var base_x: float
@export var min_pan: float = -100.0
@export var max_pan: float = 200.0
@onready var doorSprite = $doorColision/doorSprite
@export var warning_threshold: float = 100.0
const DOOR_SCENE: PackedScene = preload("res://scenes/door_scene.tscn")
var door_instance: Node2D = null

func _ready() -> void:
	base_x = position.x
	doorSprite.visible = false

func _process(delta: float) -> void:
	var target_x = base_x + clamp(Global.office_pan, min_pan, max_pan)
	position.x = lerp(position.x, target_x, delta * 3.5)
	
	var near_max = Global.office_pan >= (max_pan - warning_threshold) and Global.isOnDoorSprite

	doorSprite.visible = near_max

func _on_bonk_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_pressed("guiClick"):
		$"../bonk/bonk2".play()

func _on_door_colision_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed('guiClick'):
		Global.DoorSceneOpened = true
		_open_door()

func _open_door() -> void:
	if door_instance == null:
		door_instance = DOOR_SCENE.instantiate()
		door_instance.z_index = 100
		get_tree().current_scene.add_child(door_instance)
	door_instance.visible = true
