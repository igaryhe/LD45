extends Node2D

onready var audio_stream = $AudioStreamPlayer
onready var timer = $Timer
var distance
const TRIGGER_DISTANCE = 300
const ALERT_HIGH = 0.5
const ALERT_LOW = 1

func _on_Deadzone_body_entered(body):
	if body.get_name() == "Player":
		Player.respawn()

func _physics_process(delta):
	distance = Player.position.distance_to(position)
	# print(distance)
	# print(timer.wait_time)

func _on_Timer_timeout():
	audio_stream.play()

func _on_AudioStreamPlayer_finished():
	if distance < TRIGGER_DISTANCE:
		timer.set_wait_time(ALERT_HIGH)
	elif distance >= TRIGGER_DISTANCE:
		timer.set_wait_time(ALERT_LOW)
