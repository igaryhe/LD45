extends MarginContainer
onready var Player = get_node("/root/World/Player")
func _ready():
	Player.connect('death', self, 'death');

func change_color_indicator(color):
	print("Change")
	print(color)
	$hud/v/h/color_indicator.color = color

func success():
	print("Finish");
	$flag.show()
	_fire_animation("Flag")

func death():
	print("Death");
	_fire_animation("Death")

func _fire_animation(animation):
	$animation.set_current_animation(animation)
	$animation.play()
