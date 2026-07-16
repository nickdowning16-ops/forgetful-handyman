extends Node

@export var lives = 1

var available_tasks
var task_order

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func init_level():
	# receive available tasks
	# timer?
	# show prelevel UI (day 1, alloted time, number of tasks, etc)
	pass

func lose_life():
	print("losing a life...")
	lives -= 1
	
	if lives == 0:
		print("game over")
		get_tree().change_scene_to_file("res://UI/Scenes/main_menu.tscn") # temp
		# TODO play death
	else:
		# TODO play anim of losing a life from bar or something
		pass
