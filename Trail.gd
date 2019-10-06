extends Node2D

signal color_changed

var current_line
var lines = []

var COLORS = [
	Color("#66bb6a"),
	Color("#ffca28"),
	Color("#4fc3f7"),
]

var current_color = 0

func _process(delta):
	if Input.is_action_just_pressed("cancel"):
		if lines.size() != 0:
			var last = lines.pop_back()
			remove_child(last)
			current_line = null
	if Input.is_action_just_pressed("switch_color"):
		current_color = (current_color + 1) % COLORS.size()
		emit_signal("color_changed", COLORS[current_color])
	elif Input.is_action_just_pressed("draw"):
		create_line()
	elif Input.is_action_pressed("draw"):
		if current_line == null:
			create_line()
		current_line.add_point(get_global_mouse_position())
	pass

func create_line():
	current_line = Line2D.new()
	current_line.set_default_color(COLORS[current_color])
	lines.push_back(current_line)
	add_child(current_line)
	pass

func _ready():
	emit_signal("color_changed", COLORS[current_color])