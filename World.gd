extends Node2D

const TRIGGER_DISTANCE = 300
const ALERT_HIGH = 0.2
const ALERT_LOW = 1

onready var audio_stream = $AudioStreamPlayer
onready var timer = $Timer

var interval
var hazards = []

func _ready():
	for node in get_children():
		print(node.get_filename())
		if node.get_filename() == "res://Deadzone.tscn":
			hazards.push_back(node)

func _physics_process(delta):
	var nearest = INF
	for node in hazards:
		var dist = Player.position.distance_to(node.get_position()) 
		if dist < nearest:
			nearest = dist
	
	if nearest < TRIGGER_DISTANCE:
		interval = ALERT_HIGH
	elif nearest >= TRIGGER_DISTANCE:
		interval = ALERT_LOW
		
	print(nearest)
	print(interval)

func _on_Timer_timeout():
	audio_stream.play()

func _on_AudioStreamPlayer_finished():
	timer.start(interval)
