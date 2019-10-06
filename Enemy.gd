extends StaticBody2D
const SPEED = 100.0
var direction

func _ready():
	pass 

func _physics_process(delta):
	var motion = direction * SPEED * delta
	position += motion