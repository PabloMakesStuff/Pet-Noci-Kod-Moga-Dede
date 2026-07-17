extends AnimatedSprite2D

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
			if Global.djolePosition == 'livingroom_3' and Global.markoPosition == 'livingroom_3':
				play("livingroom_M3D3")

			if Global.djolePosition == 'livingroom_3' and Global.markoPosition == 'livingroom_1':
				play("livingroom_M1D3")
			if Global.djolePosition == 'livingroom_3' and Global.markoPosition == 'livingroom_2':
				play("livingroom_M2D3")
			if Global.djolePosition == 'livingroom_3' and Global.markoPosition == 'livingroom_3':
				play("livingroom_M3D3")
				
			if Global.djolePosition == 'hallway' and Global.markoPosition == 'room1' or Global.markoPosition == 'hallway':
				play("livingroom")

		'kitchen':
			play('kitchen')
		'balcony':
			play("balcony")
		'bathroom':
			play('bathroom')
		'room1':
			if Global.markoPosition == 'room1':
				play('room1_marko')
			else:
				play('room1')
		'hallway':
			play('hallway')
