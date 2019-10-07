extends CanvasLayer

onready var anim_player = $AnimationPlayer
onready var audio_player = $AudioStreamPlayer

func _ready():
	anim_player.play("start")
	audio_player.play()