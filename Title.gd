extends CanvasLayer

onready var anim_player = $AnimationPlayer
onready var audio_player = $AudioStreamPlayer

func _ready():
	anim_player.play("start")
	audio_player.play()
	
	var global = get_node("/root/Global")
	$cont/v/v/start.connect("pressed", global, "next")