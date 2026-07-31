extends AnimatedSprite2D

const LIVINGROOM_SPOTS := ['livingroom_1', 'livingroom_2', 'livingroom_3']

func _process(delta: float) -> void:
	updatecamera()

func updatecamera() -> void:
	match Global.currentCamera:
		'livingroom':
			if Global.djolePosition == 'livingroom_1' and Global.markoPosition == 'livingroom_1':
				play("livingroom_M1D1")
			if Global.djolePosition == 'livingroom_1' and Global.markoPosition == 'livingroom_2':
				play("livingroom_M2D1")
			if Global.djolePosition == 'livingroom_1' and Global.markoPosition == 'livingroom_3':
				play("livingroom_M3D1")

			if Global.djolePosition == 'livingroom_2' and Global.markoPosition == 'livingroom_1':
				play("livingroom_M1D2")
			if Global.djolePosition == 'livingroom_2' and Global.markoPosition == 'livingroom_2':
				play("livingroom_M2D2")
			if Global.djolePosition == 'livingroom_2' and Global.markoPosition == 'livingroom_3':
				play("livingroom_M3D2")

			if Global.djolePosition == 'livingroom_3' and Global.markoPosition == 'livingroom_1':
				play("livingroom_M1D3")
			if Global.djolePosition == 'livingroom_3' and Global.markoPosition == 'livingroom_2':
				play("livingroom_M2D3")
			if Global.djolePosition == 'livingroom_3' and Global.markoPosition == 'livingroom_3':
				play("livingroom_M3D3")
			
			if not (Global.markoPosition in LIVINGROOM_SPOTS):
				if Global.djolePosition == 'livingroom_1':
					play('livingroom_D1')
				elif Global.djolePosition == 'livingroom_2':
					play('livingroom_D2')
				elif Global.djolePosition == 'livingroom_3':
					play('livingroom_D3')
				
			if not (Global.djolePosition in LIVINGROOM_SPOTS):
				if Global.markoPosition == 'livingroom_1':
					play('livingroom_M1')
				elif Global.markoPosition == 'livingroom_2':
					play('livingroom_M2')
				elif Global.markoPosition == 'livingroom_3':
					play('livingroom_M3')
				
			if not (Global.markoPosition in LIVINGROOM_SPOTS) and not (Global.djolePosition in LIVINGROOM_SPOTS):
				play("livingroom")
		'kitchen':
			play('kitchen')
		'balcony':
			if Global.markoPosition == 'balcony':
				play('balcony_marko')
			if Global.markoPosition != 'balcony':
				play("balcony")
		'bathroom':
			if Global.AI['aleksa'] == 0: play('bathroom_empty')
			match Global.aleksaPosition:
				'bathroom_1':
					play('bathroom_1')
				'bathroom_2':
					play('bathroom_2')
				'bathroom_3':
					play('bathroom_3')
				'office':
					play('bathroom_empty')
		'room1':
			if Global.markoPosition == 'room1':
				play('room1_marko')
			else:
				play('room1')
		'hallway':
			play('hallway')
