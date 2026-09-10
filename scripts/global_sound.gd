extends Node
## Autoload as "SoundManager". Call SoundManager.play_sfx("door_close") from anywhere.
# Clanker code

const POOL_SIZE := 8  # how many sounds can overlap at once

# Preload every sound effect once, by name, so scripts never need to
# hold their own resource paths.
const SOUNDS := {
	'door_close': preload("res://textures/assets/audio/door_closing.mp3"),
	'door_open': preload("res://textures/assets/audio/door_opening.mp3"),
	'switch_camera': preload("res://textures/assets/audio/switch_camera.mp3"),
	'djole_jumpscare1': preload("res://textures/assets/audio/DjoleJSSound1.mp3"),
	'djole_jumpscare2': preload("res://textures/assets/audio/DjoleJSSound2.mp3"),
	'marko_jumpscare': preload("res://textures/assets/audio/MarkoJSSound.mp3"),
	'daddy': preload("res://textures/assets/audio/daddy.mp3"),
	'duvaj_ga1': preload("res://textures/assets/audio/DuvajGa1.mp3"),
	'duvaj_ga2': preload("res://textures/assets/audio/DuvajGa2.mp3"),
	'kolazero1': preload("res://textures/assets/audio/KolaZero1.mp3"),
	'kolazero2': preload("res://textures/assets/audio/KolaZero2.mp3"),
	'pustinet1': preload("res://textures/assets/audio/PustiNet1.mp3"),
	'pustinet2': preload("res://textures/assets/audio/PustiNet2.mp3"),
	'pustinet3': preload("res://textures/assets/audio/PustiNet3.mp3"),
	'pustinet4': preload("res://textures/assets/audio/PustiNet4.mp3"),
	'internet_fixing': preload("res://textures/assets/audio/internetFixing.mp3"),
	'teranje1': preload("res://textures/assets/audio/ajdebrebezi.mp3"),
	'teranje2': preload("res://textures/assets/audio/bezi.mp3"),
	'teranje3': preload("res://textures/assets/audio/nema.mp3"),
	'teranje4': preload("res://textures/assets/audio/nemozemo.mp3")
}

var _pool: Array[AudioStreamPlayer] = []
var _next_index := 0

func _ready() -> void:
	for i in POOL_SIZE:
		var player := AudioStreamPlayer.new()
		add_child(player)
		_pool.append(player)

func play_sfx(sound_name: String, volume_db: float = 0.0, duration: float = -1.0) -> void:
	if not SOUNDS.has(sound_name):
		push_error("SoundManager: no sound registered for '%s'" % sound_name)
		return

	#ubacuje sound u listu svih zvukova
	var player := _pool[_next_index]
	_next_index = (_next_index + 1) % POOL_SIZE

	player.stream = SOUNDS[sound_name]
	player.volume_db = volume_db
	player.play()

	if duration > 0.0:
		await stop_after(player, duration)
	else:
		await player.finished

func stop_after(player: AudioStreamPlayer, duration: float) -> void:
	var stream_at_call := player.stream
	await get_tree().create_timer(duration).timeout
	if player.stream == stream_at_call and player.playing:
		player.stop()
