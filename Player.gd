extends KinematicBody2D

const MOVE_SPEED = 500
const JUMP_FORCE = 900
const GRAVITY = 50
const MAX_FALL_SPEED = 1000

var y_velocity = 0

func _physics_process(delta):
	var dir = 0
	if Input.is_action_pressed("ui_right"):
		dir += 1
	if Input.is_action_pressed("ui_left"):
		dir -= 1
	move_and_slide(Vector2(dir * MOVE_SPEED, y_velocity), Vector2(0, -1))

	var grounded = is_on_floor()
	y_velocity += GRAVITY
	if grounded and Input.is_action_just_pressed("jump"):
		y_velocity = -JUMP_FORCE
	if grounded and y_velocity >= 5:
		y_velocity = 5
	if y_velocity > MAX_FALL_SPEED:
		y_velocity = MAX_FALL_SPEED
	pass