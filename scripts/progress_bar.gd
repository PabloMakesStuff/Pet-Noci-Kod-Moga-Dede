extends ProgressBar

@export var smoothing_speed: float = 6.0  # higher = catches up faster

func _ready() -> void:
	value = Global.aleksaChargePercent  # start in sync, no initial fill-up animation

func _process(delta: float) -> void:
	value = lerp(value, Global.aleksaChargePercent, smoothing_speed * delta)
