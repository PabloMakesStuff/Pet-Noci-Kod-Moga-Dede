extends Area2D

func _ready() -> void:
	mouse_entered.connect(mouseEntered)
	mouse_exited.connect(mouseExited)

func mouseEntered() -> void:
	if name == 'leftBox':
		Global.camera_pan += 300.0
		print("camera pan is now: ", Global.camera_pan)
	else:
		Global.camera_pan -= 300.0
		
func mouseExited() -> void:
	if name == 'leftBox':
		Global.camera_pan -= 300.0
		print("camera pan is now: ", Global.camera_pan)
	else:
		Global.camera_pan += 300.0
