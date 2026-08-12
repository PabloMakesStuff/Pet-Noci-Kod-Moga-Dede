extends Node2D

# Aleksa move pattern
# if interte = disabled
# play sound effect
# movement starts 1 -> 2 -> 3 -> office

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.timeout.connect(timeout)

func timeout() -> void:
	if randf_range(1,20) <= Global.AI['aleksa'] and Global.aleksaChargePercent == 0.0:
		move()
	if Global.aleksaChargePercent > 0.0 and Global.aleksaPosition != 'bathroom_1':
		Global.aleksaPosition = 'bathroom_1'

func move() -> void:
	match Global.aleksaPosition:
		'bathroom_1':
			Global.aleksaPosition = 'bathroom_2'
		'bathroom_2':
			Global.aleksaPosition = 'bathroom_3'
		'bathroom_3':
			Global.aleksaPosition = 'office'
	print('Aleksa: ' + Global.aleksaPosition)
