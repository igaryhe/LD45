extends Area2D

var picked = false

onready var Player = get_node("/root/World/Player")
func on_collide(body):
	if picked:
		return
	if body.get_name() == "Player":
		Player.grab_key()
		$Pickup.play()
		$Sprite.hide()
		$Ring.stop()
		picked = true
