extends Area2D

signal complete

func collide(body):
	if body.get_name() == "Player":
		print("Finish")
		var fsm = get_node("/root/Global").get_player().get_node("StateMachine")
		fsm.set_state(fsm.states.win)
		var gui = get_tree().get_current_scene().get_node("Draw")
		gui.complete()
