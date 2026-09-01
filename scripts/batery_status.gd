extends AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var x = Global.aleksaChargePercent
	if (x <= 100.0 and x > 80.0):
		play('full_batery')
	if (x <= 80.0 and x > 60.0):
		play("lessfull_batery")
	if (x <= 60.0 and x > 40.0):
		play("half_batery")
	if (x <= 40.0 and x > 20.0):
		play("lesshalf_batery")
	if (x <= 20.0 and x > 0.0):
		play("empty_battery")
