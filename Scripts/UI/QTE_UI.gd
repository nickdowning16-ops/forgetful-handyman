extends Control
@onready var time_bar = $BackgroundPanel/WindowPanel/WindowVBoxContainer/UpperWindow/UpperVBoxContainer/TimeBar

var starting_time = 0
var time_left = 0

func get_event_container():
	return $BackgroundPanel/WindowPanel/WindowVBoxContainer/LowerWindow

func _ready():
	pass # Replace with function body.

func _process(delta):
	time_left -= delta
	time_bar.value = (time_left / starting_time) * 100 # bamboozled by not having 100 for a min there

func init(time):
	starting_time = time
	time_left = time

func end(was_completed):
	if was_completed:
		# do something good
		pass
	else:
		# do something bad
		pass
	
	QTE_Manager.complete_QTE()

func _on_cheat_button_pressed():
	end(true)
