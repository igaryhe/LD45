extends Node2D

const IDLE_DURATION = 1.0
export(float) var distance = 100
export(Vector2) var direction = Vector2.RIGHT
export(float) var speed = 3
var move_to

var follow = Vector2.ZERO

onready var platform = $Platform
onready var tween = $Tween

func _ready():
	move_to = direction * distance
	_init_tween()

func _init_tween():
	var duration = distance / float(speed * 100)
	tween.interpolate_property(self, "follow", Vector2.ZERO, move_to, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, IDLE_DURATION)
	tween.interpolate_property(self, "follow", move_to, Vector2.ZERO, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, IDLE_DURATION * 2 + duration)
	tween.start()

func _physics_process(delta):
	platform.position = platform.position.linear_interpolate(follow, 0.075)

func _on_AudioStreamPlayer2D_finished():
	$Platform/AudioStreamPlayer2D.play()
