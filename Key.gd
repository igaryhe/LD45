extends Area2D

onready var Player = get_node("/root/World/Player")
func on_collide(body):
	if body.get_name() == "Player":
		Player.grab_key()
