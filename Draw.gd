extends Node

var completed = false

func complete():
	if !completed:
		completed = true
		$GUILayer/GUI.success()
