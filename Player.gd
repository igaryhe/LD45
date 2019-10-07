extends KinematicBody2D

const MOVE_SPEED = [100, 300, 500]
const JUMP_FORCE = 900
const JUMP_SLACK = 0.1
const GRAVITY = 50
const MAX_FALL_SPEED = 1000

var air_frame = 0
var velocity = Vector2.ZERO
var was_grounded
var grounded

var move_held_for = 0
var move_dir = 0
var keys_held = 0
var disabled = false

signal death

onready var anim_player = $AnimationPlayer

func _ready():
	init_pos()
	move_and_slide(Vector2.ZERO, Vector2.UP)
	grounded = is_on_floor()
	$DeathParticles.one_shot = true

func init_pos():
	position = Vector2(100, 416)
	$Sprite.show()

func respawn():
	emit_signal('death')
	$DeathParticles.emitting = true
	$Sprite.hide()
	$RespawnTimer.start(1)

func apply_gravity():
	velocity.y += GRAVITY

func apply_movement():
	var dir = 0
	if !disabled:
		if Input.is_action_pressed("ui_right"):
			dir += 1
		if Input.is_action_pressed("ui_left"):
			dir -= 1

	if dir != move_dir:
		move_dir = dir
		move_held_for = 0
	elif move_held_for < 2:
		move_held_for += 1

	velocity.x = move_dir * MOVE_SPEED[move_held_for]
	move_and_slide(velocity, Vector2(0, -1))

func apply_jump(delta):
	was_grounded = grounded
	grounded = is_on_floor()

	if grounded:
		air_frame = 0
	else:
		air_frame += delta

	if air_frame < JUMP_SLACK and Input.is_action_just_pressed("jump"):
		velocity.y = -JUMP_FORCE
	if grounded and velocity.y >= 5:
		velocity.y = 5
	if velocity.y > MAX_FALL_SPEED:
		velocity.y = MAX_FALL_SPEED

func grab_key():
	keys_held += 1

func get_key_count():
	return keys_held

func set_disabled(d):
	disabled = d
