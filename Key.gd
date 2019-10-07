extends Area2D

var picked = false

func on_collide(body):
	if picked:
		return
	if body.get_name() == "Player":
		get_node("/root/Global").get_player().grab_key()
		$Pickup.play()
		$Sprite.hide()
		$Ring.stop()
		picked = true
