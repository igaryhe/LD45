extends MarginContainer

func _ready():
	pass

func change_color_indicator(color):
	print("Change")
	print(color)
	$v/h/color_indicator.color = color