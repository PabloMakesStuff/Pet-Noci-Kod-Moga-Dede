extends Area2D

func _ready() -> void:
	Global.office_pan = 0.0
	mouse_entered.connect(mouseEntered)
	mouse_exited.connect(mouseExited)

func mouseEntered() -> void:
	Global.office_pan += 300.0
	print("pan is now: ", Global.office_pan)
	
func mouseExited() -> void:
	Global.office_pan -= 300.0
	print("pan is now: ", Global.office_pan)

#var target_x = base_x + clamp(Global.office_pan, min_pan, max_pan)
#position.x = lerp(position.x, target_x, delta * 3.5)
