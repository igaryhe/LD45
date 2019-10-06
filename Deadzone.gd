extends Node2D

onready var audio_stream = $AudioStreamPlayer
onready var timer = $Timer
var distance
var interval
const TRIGGER_DISTANCE = 300
const ALERT_HIGH = 0.2
const ALERT_LOW = 0.5

func _on_Deadzone_body_entered(body):
	if body.get_name() == "Player":
		Player.respawn()

func _physics_process(delta):
	distance = Player.position.distance_to(position)
	if distance < TRIGGER_DISTANCE:
		interval = ALERT_HIGH
	elif distance >= TRIGGER_DISTANCE:
		interval = ALERT_LOW

func _on_Timer_timeout():
	audio_stream.play()

func _on_AudioStreamPlayer_finished():
	timer.start(interval)