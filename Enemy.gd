extends StaticBody2D
const SPEED = 100.0
var direction
var distance
onready var player = get_node("/root/Player")
onready var audio_stream = get_node("/root/Player/AudioStreamPlayer2D")
func _ready():
	pass 

func _physics_process(delta):
	distance = player.get_position().distance_to(get_position())
	if distance < 300 and !audio_stream.playing:
		audio_stream.play()
	elif distance >= 300 and audio_stream.playing:
		audio_stream.stop()
	direction = (player.position - position).normalized()
	var motion = direction * SPEED * delta
	position += motion