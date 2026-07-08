extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(mouseEntered)
	mouse_exited.connect(mouseExited)
	
func mouseEntered() -> void:
	Global.isOnDoorSprite = true

func mouseExited() -> void:
	Global.isOnDoorSprite = false
