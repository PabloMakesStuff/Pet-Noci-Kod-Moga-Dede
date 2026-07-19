extends Area2D

func _ready() -> void:
	$Sprite2D.visible = false

func _on_mouse_entered() -> void:
	print('Mouse entered')
	$Sprite2D.visible = true

func _on_mouse_exited() -> void:
	print('Mouse exited')
	$Sprite2D.visible = false

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_pressed('guiClick'):
		Global.DoorSceneOpened = false
		Global.office_pan = 0.0
		owner.visible = false
