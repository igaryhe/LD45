extends StaticBody2D
const SPEED = 100.0
const TRIGGER_DISTANCE = 300
var direction
var distance
onready var audio_stream = get_node("/root/Player/AudioStreamPlayer2D")
func _ready():
	pass 

func _physics_process(delta):
	distance = Player.get_position().distance_to(get_position())
	if distance < TRIGGER_DISTANCE and !audio_stream.playing:
		audio_stream.play()
	elif distance >= TRIGGER_DISTANCE and audio_stream.playing:
		audio_stream.stop()
	direction = (Player.position - position).normalized()
	position += direction * SPEED * delta