extends MarginContainer
onready var Player = get_node("/root/World/Player")
func _ready():
	Player.connect('death', self, 'death');
	Player.connect('key_state_changed', self, 'toggle_key');

func change_color_indicator(color):
	$hud/v/h/pen/pen.modulate = color

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

func toggle_key(state):
	print("Toggle")
	if state:
		$hud/v/h/key.show()
	else:
		$hud/v/h/key.hide()
