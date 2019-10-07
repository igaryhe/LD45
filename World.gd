extends Node2D

const TRIGGER_DISTANCE = 600
const ALERT_HIGH = 0.2
const ALERT_LOW = 1
const ALERT_SCALE = 1

onready var audio_stream = $AudioStreamPlayer
onready var timer = $Timer
onready var Player = $Player

var interval
var hazards = []
var completed = false

func _ready():
	Player.set_disabled(false)
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
	#	interval = ALERT_HIGH
		audio_stream.set_volume_db(0)
	elif nearest >= TRIGGER_DISTANCE:
	#	interval = ALERT_LOW
		audio_stream.set_volume_db(-80)
	interval = ALERT_SCALE * nearest/TRIGGER_DISTANCE

func _on_Timer_timeout():
	audio_stream.play()

func _on_AudioStreamPlayer_finished():
	timer.start(interval)

func complete():
	if !completed:
		completed = true
		$GUILayer/GUI.success()
		Player.set_disabled(true)
