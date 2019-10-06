extends Node2D

onready var audio_stream = $AudioStreamPlayer
var distance
const TRIGGER_DISTANCE = 300

func _on_Deadzone_body_entered(body):
	if body.get_name() == "Player":
		Player.respawn()

func _ready():
	print(audio_stream.stream.get_length())
	pass

func _physics_process(delta):
	distance = Player.position.distance_to(position)
	if distance < TRIGGER_DISTANCE and !audio_stream.playing:
		audio_stream.pitch_scale = 1.5
		audio_stream.play()
	elif distance >= TRIGGER_DISTANCE and audio_stream.playing:
		audio_stream.stop()