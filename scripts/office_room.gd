extends Sprite2D

var base_x: float
@export var min_pan: float = -100.0
@export var max_pan: float = 170.0
@onready var doorSprite = $doorColision/doorSprite
@export var warning_threshold: float = 100.0

func _ready() -> void:
	base_x = position.x
	doorSprite.visible = false

func _process(delta: float) -> void:
	var target_x = base_x + clamp(Global.office_pan, min_pan, max_pan)
	position.x = lerp(position.x, target_x, delta * 3.0)
	
	var near_max = Global.office_pan >= (max_pan - warning_threshold) and Global.isOnDoorSprite

	doorSprite.visible = near_max
