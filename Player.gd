extends KinematicBody2D

const MOVE_SPEED = [100, 300, 500]
const JUMP_FORCE = 900
const JUMP_SLACK = 0.1
const GRAVITY = 50
const MAX_FALL_SPEED = 1000

var y_velocity = 0
var air_frame = 0

var move_held_for = 0
var move_dir = 0

var keys_held = 0

var was_grounded
var grounded

func _ready():
	init_pos()
	move_and_slide(Vector2.ZERO, Vector2.UP)
	grounded = is_on_floor()
	$DeathParticles.one_shot = true

func init_pos():
	position = Vector2(100, 416)

func respawn():
	$DeathParticles.emitting = true
	$DeathParticles.restart()
	#init_pos()
	$Sprite.hide()

func _physics_process(delta):
	
	var dir = 0
	if Input.is_action_pressed("ui_right"):
		dir += 1
	if Input.is_action_pressed("ui_left"):
		dir -= 1

	if dir != move_dir:
		move_dir = dir
		move_held_for = 0
	elif move_held_for < 2:
		move_held_for += 1

	move_and_slide(Vector2(move_dir * MOVE_SPEED[move_held_for], y_velocity), Vector2(0, -1))

	was_grounded = grounded
	grounded = is_on_floor()
	if grounded and !was_grounded:
		$AnimationPlayer.play("land")
	if grounded:
		air_frame = 0
	else:
		air_frame += delta

	y_velocity += GRAVITY
	if air_frame < JUMP_SLACK and Input.is_action_just_pressed("jump"):
		$AnimationPlayer.play("jump")
		y_velocity = -JUMP_FORCE
	if grounded and y_velocity >= 5:
		y_velocity = 5
	if y_velocity > MAX_FALL_SPEED:
		y_velocity = MAX_FALL_SPEED

func grab_key():
	keys_held += 1

func get_key_count():
	return keys_held
