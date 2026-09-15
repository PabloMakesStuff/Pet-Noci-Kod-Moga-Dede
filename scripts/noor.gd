extends AnimatedSprite2D

var sound = ['kolazero1','kolazero2','pustinet1','pustinet2','pustinet3','pustinet4']

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.DoorSceneOpened = true
	if Global.isDoorClosed == true:
		$".".play('Prazno_ot')
	else:
		$".".play("Prazno_zat")
		
	Global.jumpscare_requested.connect(_on_jumpscare_requested)
	
	
func _on_jumpscare_requested(which: String) -> void:
	match which:
		"marko":
			$"../jumpscare_marko".show()
			$"../jumpscare_marko".play('marko')
			jumpscare_transition('marko')
		'djole':
			$"../jumpscares".show()
			$"../jumpscares".play("djole")
			jumpscare_transition('djole')
		'aleksa':
			$"../jumpscares".show()
			$"../jumpscares".play("aleksa")
			jumpscare_transition('aleksa')

func jumpscare_transition(charachter: String) -> void:
	get_tree().paused = true
	match charachter:
		'djole':
			await SoundManager.play_sfx(['djole_jumpscare1','djole_jumpscare2'].pick_random())
		'marko':
			await SoundManager.play_sfx('marko_jumpscare')
		'aleksa':
			print('pusi ga aleksa')
	
	await get_tree().create_timer(1.5, true).timeout
	SceneTransition.fade_to_scene("res://scenes/game_over_scene.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Global.isDoorClosed:
		if $".".animation != "Prazno_zat":
			$".".play("Prazno_zat")
	else:
		if Global.djolePosition == "hallway":
			if $".".animation != "Djole":
				$".".play("Djole")
		elif Global.markoPosition == "hallway":
			if $".".animation != "Marko":
				$".".play("Marko")
				SoundManager.play_sfx(sound.pick_random())
		else:
			if $".".animation != "Prazno_ot":
				$".".play("Prazno_ot")

func _on_button_pressed() -> void:
	if Global.isDoorClosed == true:
		SoundManager.play_sfx('door_close')
	else:
		SoundManager.play_sfx('door_open')
	Global.isDoorClosed = not Global.isDoorClosed
