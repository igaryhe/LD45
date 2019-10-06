extends Node2D

func _on_Deadzone_body_entered(body):
	Player.init_pos()