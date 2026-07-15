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
