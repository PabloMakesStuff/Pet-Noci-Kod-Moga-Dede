extends AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$rest.connect("timeout", restTimeout)
	$twitch.connect("timeout", twitchTimeout)
	restStart()

func restTimeout() -> void:
	frame = randi_range(1,3)
	twitchStart()

func twitchTimeout() -> void:
	frame = 0
	restStart()
	
func restStart() -> void:
	$rest.wait_time = randf_range(0.3, 4.0)
	$rest.start()

func twitchStart() -> void:
	$rest.wait_time = randf_range(0.02, 0.07)
	$twitch.start()
