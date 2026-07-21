extends Control
@onready var time_bar = $BackgroundPanel/WindowPanel/UpperWindow/UpperVBoxContainer/TimeBar

var starting_time = 0
var time_left = 0

func get_event_container():
	return $BackgroundPanel/WindowPanel/LowerWindow

func _ready():
	open_anim()

func _process(delta):
	time_left -= delta
	time_bar.value = (time_left / starting_time) * 100 # bamboozled by not having 100 for a min there

func init(time):
	starting_time = time
	time_left = time

func end(was_completed):
	if was_completed:
		$BackgroundPanel/WindowPanel/PassBox.visible = true
		pass
	else:
		$BackgroundPanel/WindowPanel/FailBox.visible = true
		pass
	
	#QTE_Manager.complete_QTE()

func open_anim():
	await get_tree().process_frame  # let layout settle first
	pivot_offset = size / 2.0
	scale = Vector2.ZERO
	
	scale = Vector2.ZERO
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_BACK)
	tween.tween_property(self, "scale", Vector2.ONE, 0.5)

func _on_cheat_button_pressed():
	end(true)
