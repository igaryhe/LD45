extends KinematicBody2D

var annihilated = false

func annihilate():
	print("Annihilate")
	$collision.set_disabled(true)
	annihilated = true
