extends CanvasLayer

func _input(event):
	if event.is_action_pressed("ui_select"):
		get_tree().change_scene("res://Title.tscn")