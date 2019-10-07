extends Node

signal level_updated

const LEVELS = [
	"res://Level1.tscn",
	"res://Level2.tscn",
	"res://Level3.tscn",
	"res://Level4.tscn",
	"res://Level5.tscn",
	"res://Level6.tscn",
]

const START = "res://Title.tscn"

var cur_level = 0
var player = null

func next():
	if cur_level == LEVELS.size():
		cur_level = 0
		switch(START)
		emit_signal("level_updated", cur_level)
	else:
		switch(LEVELS[cur_level])
		cur_level+=1
		emit_signal("level_updated", cur_level)

func switch(scene):
	var cur_inst = get_tree().get_current_scene()

	if cur_inst != null:
		cur_inst.queue_free()

	var res = ResourceLoader.load(scene)
	var inst = res.instance();

	cur_inst = inst
	cur_inst.set_name("Level")

	get_tree().get_root().add_child(cur_inst)
	get_tree().set_current_scene(cur_inst)

func register_player(pl):
	player = pl

func get_player():
	return player
