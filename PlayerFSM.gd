extends StateMachine

func _ready():
	add_state("idle")
	add_state("move")
	add_state("jump")
	add_state("fall")
	add_state("death")
	add_state("win")
	call_deferred("set_state", states.idle)

func _state_logic(delta):
	if state == states.win:
		parent.apply_win()
	if state != states.death and state != states.win:
		parent.apply_movement()
		parent.apply_gravity()
		parent.apply_jump(delta)
	pass

func _get_transition(delta):
	match state:
		states.idle:
			if !parent.is_on_floor():
				if parent.velocity.y < 0:
					return states.jump
				elif parent.velocity.y >= 0:
					return states.fall
				elif parent.velocity.x != 0:
					return states.move
		states.move:
			if !parent.is_on_floor():
				if parent.velocity.y < 0:
					return states.jump
				elif parent.velocity.y >= 0:
					return states.fall
			elif parent.velocity.x == 0:
				return states.idle
		states.jump:
			if parent.is_on_floor():
				return states.idle
			elif parent.velocity.y >= 0:
				return states.fall
		states.fall:
			if parent.is_on_floor():
				return states.idle
			elif parent.velocity.y < 0:
				return states.jump
	return null

func _enter_state(new_state, old_state):
	match new_state:
		states.jump:
			parent.anim_player.play("jump")
			parent.jump_sound.play()
		states.death:
			emit_signal('death')
			parent.death_sound.play()
			parent.sprite.hide()
			parent.particles.emitting = true
			parent.respawn_timer.start(1)

func _exit_state(old_state, new_state):
	if old_state == states.fall and new_state == states.idle:
		parent.anim_player.play("land")
