extends Node2D

func _on_Deadzone_body_entered(body):
	if body.get_name() == "Player":
		Player.respawn()
