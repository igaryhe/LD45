extends KinematicBody2D

const MOVE_SPEED = [100, 300, 500]
const JUMP_FORCE = 900
const JUMP_SLACK = 0.1
const GRAVITY = 50
const MAX_FALL_SPEED = 1000

const TRIGGER_DISTANCE = 600
const ALERT_HIGH = 0.2
const ALERT_LOW = 1
const ALERT_SCALE = 1

var air_frame = 0
var velocity = Vector2.ZERO
var was_grounded
var grounded
var stuck
var was_stuck
var stuck_on_door
var door_opened

var move_held_for = 0
var move_dir = 0
var key_held = false
var disabled = false
var zoom_factor = 1

signal death
signal key_state_changed

onready var anim_player = $AnimationPlayer
onready var jump_sound = $AudioStreamPlayer
onready var particles = $DeathParticles
onready var respawn_timer = $RespawnTimer
onready var sprite = $Sprite
onready var hb = $HeartBeat
onready var spawn = position
onready var hb_timer = $Timer

var hazards = []
var interval

func _ready():
	move_and_slide(Vector2.ZERO, Vector2.UP)
	grounded = is_on_floor()
	set_disabled(false)
	for node in get_node("..").get_children():
		if node.get_filename() == "res://Deadzone.tscn":
			hazards.push_back(node)

func init_pos():
	$StateMachine.set_state($StateMachine.states.idle)
	position = spawn
	$Sprite.show()

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
	move_and_slide(velocity, Vector2.UP)

	stuck_on_door = false
	door_opened = false
	for i in range(get_slide_count()):
		var collision = get_slide_collision(i)
		if collision.collider is Node2D:
			if collision.collider.get_filename() == "res://Door.tscn":
				stuck_on_door = true
				if use_key():
					door_opened = true
					collision.collider.annihilate()

func apply_jump(delta):
	was_grounded = grounded
	was_stuck = stuck
	stuck = is_on_wall()
	grounded = is_on_floor()

	if stuck and !was_stuck:
		if !stuck_on_door:
			$WallSound.play()
		else:
			$DoorSound.play()
	
	if door_opened:
		$DoorOpen.play()
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
	key_held = true
	emit_signal("key_state_changed", key_held)

func use_key():
	if !key_held:
		return false
	key_held = false
	emit_signal("key_state_changed", key_held)
	return true

func set_disabled(d):
	disabled = d

func _heart_beat():
	var nearest = INF
	for node in hazards:
		var dist = position.distance_to(node.get_position()) 
		if dist < nearest:
			nearest = dist
	
	if nearest < TRIGGER_DISTANCE:
	#	interval = ALERT_HIGH
		hb.set_volume_db(0)
	elif nearest >= TRIGGER_DISTANCE:
	#	interval = ALERT_LOW
		hb.set_volume_db(-80)
	interval = ALERT_SCALE * nearest / TRIGGER_DISTANCE
	pass

func _physics_process(delta):
	_heart_beat()

func _on_timer_timeout():
	hb.play()

func _on_hb_finished():
	hb_timer.start(interval)

func _input(event):
	# zoom in
	if event.is_action_pressed("zoom_out"):
		zoom_factor += 0.2
		$Camera2D.set_zoom(Vector2(zoom_factor, zoom_factor))
    # zoom out
	if event.is_action_pressed("zoom_in"):
		zoom_factor -= 0.2
		$Camera2D.set_zoom(Vector2(zoom_factor, zoom_factor))
