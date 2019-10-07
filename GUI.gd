extends MarginContainer
func _ready():
	var Player = get_node("/root/Global").get_player()
	Player.connect('key_state_changed', self, 'toggle_key');

func change_color_indicator(color):
	$hud/v/h/pen/pen.modulate = color

func success():
	print("Finish");
	$flag.show()
	_fire_animation("Flag")

func _fire_animation(animation):
	$animation.set_current_animation(animation)
	$animation.play()

func reset():
	$animation.seek(0)
	$flag.hide()

func toggle_key(state):
	if state:
		$hud/v/h/key.show()
	else:
		$hud/v/h/key.hide()
