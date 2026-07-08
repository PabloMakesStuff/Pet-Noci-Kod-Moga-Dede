extends Sprite2D

var base_x: float
@export var min_pan: float = -100.0
@export var max_pan: float = 200.0
@onready var doorSprite = $doorColision/doorSprite
@export var warning_threshold: float = 100.0

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
	if Global.camera_active == true:
		visible = false
	if event.is_action_pressed('guiClick'):
		get_tree().paused = true
		Transition.fade_to_scene("res://scenes/door_scene.tscn")
