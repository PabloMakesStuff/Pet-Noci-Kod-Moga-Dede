extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect('mouse_entered', mouseEntered)
	
func mouseEntered() -> void:
	if ($"../arrow".position.y != position.y):
		$"../select change".play()
	$"../arrow".position.y = position.y
