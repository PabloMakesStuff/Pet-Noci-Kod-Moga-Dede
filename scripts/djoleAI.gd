extends Node2D

# Djole movement mapa
# livingroom_1 -> livingroom_2 -> balcony ->livingroom_3 -> hallway

func _ready() -> void:
	$Timer.timeout.connect(timeout)

func timeout() -> void:
	if randi_range(1 ,20) <= Global.AI['djole']:
		move()
		

func move() -> void:
	match Global.djolePosition:
		'livingroom_1':
			Global.djolePosition = 'livingroom_2'
		'livingroom_2':
			Global.djolePosition = 'livingroom_3'
			#Global.djolePosition = ['livingroom_3','balcony'].pick_random()
		'livingroom_3':
			Global.djolePosition = 'hallway'
	print(Global.djolePosition)
