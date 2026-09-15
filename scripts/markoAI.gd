extends Node2D

# Marko movement mapa
# livingroom_1 -> livingroom_2 -> livingroom_3
# livingroom_3 <-> room1_marko, balcony_marko
# room1 <-> hallway, livingroom_3

var sound = ['duvaj_ga1','duvaj_ga2']

func _ready() -> void:
	$Timer.timeout.connect(timeout)

func timeout() -> void:
	if randi_range(1 ,20) <= Global.AI['marko']:
		move()

func move() -> void:
	match Global.markoPosition:
		'livingroom_1':
			Global.markoPosition = 'livingroom_2'
		'livingroom_2':
			Global.markoPosition = 'livingroom_3'
		'livingroom_3':
			#Global.markoPosition = ['room1','balcony'].pick_random()
			Global.markoPosition = 'hallway'
		'balcony':
			Global.markoPosition = 'livingroom_3'
		'room1':
			Global.markoPosition = ['hallway', 'livingroom_3'].pick_random()
		'hallway':
			if Global.djolePosition == 'hallway':
				Global.markoPosition = 'room1'
			if (Global.isDoorClosed == false and Global.markoRepelPressed == true):
				await SoundManager.play_sfx(sound.pick_random())
				Global.markoPosition = 'livingroom_2'
			else:
				Global.markoPosition = 'office'
				$Timer.wait_time = 2.0
		'office':
			$Timer.stop()
			Global.jumpscare_requested.emit('marko')

	print('marko: ', Global.markoPosition)
