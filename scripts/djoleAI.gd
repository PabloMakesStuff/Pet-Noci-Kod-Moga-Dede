extends Node2D

# Djole movement mapa
# livingroom_1 -> livingroom_2 -> livingroom_3 -> kitchen -> hallway
# kitchen - ulazi nevidljivo i ima sansu da polomi internet, ako se to desi, moras da drzis
# dugme u kuhinji da bi ga popravio

func _ready() -> void:
	$Timer.timeout.connect(timeout)

func timeout() -> void:
	if randi_range(1, 20) <= Global.AI['djole']:
		move()

func move() -> void:
	match Global.djolePosition:
		'livingroom_1':
			Global.djolePosition = 'livingroom_2'
		'livingroom_2':
			Global.djolePosition = 'livingroom_3'
		'livingroom_3':
			if randi_range(1, 5) == 3:
				Global.djolePosition = 'kitchen'
				Global.isInternetBroken = true
			if Global.markoPosition == 'hallway':
				Global.djolePosition = 'livingroom_3'
			else:
				Global.djolePosition = 'hallway'
		'kitchen':
			Global.djolePosition = 'hallway'
		'hallway':
			if Global.isDoorClosed == true:
				Global.djolePosition = 'livingroom_2'
			else:
				Global.djolePosition = 'office'
	print('djole: ',Global.djolePosition)
