extends Node2D

@onready var label: Label = $GUI/Label
@export var display_seconds: float = 2.5

func _ready() -> void:
	label.text = "Noć %d zavrsena!" % Global.currentNight
	await get_tree().create_timer(display_seconds, true).timeout
	SceneTransition.fade_to_scene("res://scenes/tittle.tscn")
