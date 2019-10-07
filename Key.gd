extends Area2D

func on_collide(body):
	if body.get_name() == "Player":
		Player.grab_key()
