extends QTE

@export var total_time: float = 6.0
@export var hit_window_start: float = 3.0
@export var hit_window_end: float = 4.0
@export var idle_vibrate_strength: float = 2.0
@export var idle_vibrate_speed: float = 0.05

var time_elapsed: float = 0.0
var has_swung: bool = false
var base_rotation: float = 0.0
var idle_tween: Tween

func _ready():
	start_idle_vibration()

func _process(delta):
	if has_swung:
		return
		
	time_elapsed += delta
	
	if time_elapsed >= hit_window_start and time_elapsed <= hit_window_end:
		$Hammer/Sprite2D.modulate = Color(0.5, 1.5, 0.5)
	else:
		$Hammer/Sprite2D.modulate = Color(1,1,1)
	
	if time_elapsed >= total_time:
		# ran out the whole timer without pressing at all
		QTE_Manager.failed_QTE()
		return
		
	if Input.is_action_just_pressed("swing_hammer"):
		attempt_swing()

func start_idle_vibration():
	idle_tween = create_tween()
	idle_tween.set_loops()
	idle_tween.tween_property($Hammer, "rotation", base_rotation + deg_to_rad(idle_vibrate_strength), idle_vibrate_speed)
	idle_tween.tween_property($Hammer, "rotation", base_rotation - deg_to_rad(idle_vibrate_strength), idle_vibrate_speed)
	
func attempt_swing():
	has_swung = true
	idle_tween.kill()  # stop vibration immediately

	if time_elapsed >= hit_window_start and time_elapsed <= hit_window_end:
		good_swing()
	else:
		bad_swing()

func good_swing():
	$Hammer.rotation = base_rotation
	var swing_tween = create_tween()
	swing_tween.set_ease(Tween.EASE_OUT)
	swing_tween.set_trans(Tween.TRANS_BACK)

	# wind up slightly, then swing down toward the nail
	swing_tween.tween_property($Hammer, "rotation", base_rotation - deg_to_rad(30), 0.1)
	swing_tween.tween_property($Hammer, "rotation", base_rotation + deg_to_rad(60), 0.15)
	
	QTE_Manager.passed_QTE()

func bad_swing():
	$Hammer.rotation = base_rotation
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_BACK)

	# wind up but overshoot at a skewed angle
	# like it clipped the nail sideways instead of striking true
	tween.tween_property($Hammer, "rotation", base_rotation - deg_to_rad(30), 0.1)
	tween.tween_property($Hammer, "rotation", base_rotation + deg_to_rad(75), 0.12)
	tween.tween_property($Hammer, "rotation", base_rotation + deg_to_rad(45), 0.08)
	
	QTE_Manager.failed_QTE()
	
