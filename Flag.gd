extends Area2D

signal complete

func collide(body):
	if body.get_name() == "Player":
		print("Finish");
		emit_signal('complete');
