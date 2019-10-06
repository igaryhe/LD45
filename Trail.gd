extends Node2D

var current_line
var lines = []

func _process(delta):
	if Input.is_action_just_pressed("cancel"):
		if lines.size() != 0:
			var last = lines.pop_back()
			remove_child(last)
			current_line = null
	elif Input.is_action_just_pressed("draw"):
		create_line()
	elif Input.is_action_pressed("draw"):
		if current_line == null:
			create_line()
		current_line.add_point(get_global_mouse_position())
	pass

func create_line():
	current_line = Line2D.new()
	lines.push_back(current_line)
	add_child(current_line)
	pass