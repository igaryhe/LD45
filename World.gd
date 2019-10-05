extends Node2D
var distance

func _physics_process(delta):
	distance = $Player.get_position().distance_to($Enemy.get_position())
	print(distance)
	if distance < 300:
		$Player/AudioStreamPlayer2D.set_pitch_scale(1.2)
	else:
		$Player/AudioStreamPlayer2D.set_pitch_scale(1)