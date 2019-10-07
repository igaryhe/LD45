extends Area2D

signal complete

func collide(body):
	if body.get_name() == "Player":
		print("Finish")
		var fsm = get_node("/root/World/Player/StateMachine")
		fsm.set_state(fsm.states.win)
		emit_signal('complete')