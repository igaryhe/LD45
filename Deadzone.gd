extends Node2D

func _on_Deadzone_body_entered(body):
	if body.get_name() == "Player":
		#Player.respawn()
		var state_machine = get_node("/root/Global").get_player().get_node("StateMachine")
		state_machine.set_state(state_machine.states.death)
