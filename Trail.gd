extends Node2D

var current_line

func _process(delta):
	if Input.is_action_just_pressed("draw"):
		create_line()
	elif Input.is_action_pressed("draw"):
		current_line.add_point(get_global_mouse_position())
	pass

func create_line():
	current_line = Line2D.new()
	add_child(current_line)
	pass