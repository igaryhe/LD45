extends CanvasLayer

onready var anim_player = $AnimationPlayer

func _ready():
	anim_player.play("start")
	
	var global = get_node("/root/Global")
	$cont/v/v/start.connect("pressed", global, "next")
