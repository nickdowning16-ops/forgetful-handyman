extends QTE

@export var total_time: float = 6.0
@export var idle_vibrate_strength: float = 0.5
@export var idle_vibrate_speed: float = 0.05

var time_elapsed: float = 0.0
var has_swung: bool = false
var base_rotation: float = 0.0
var idle_tween: Tween
var num_tries = 1

var is_holding: bool = false
var hold_value: float = 0
var hold_slider_direction = 1
@export var charge_speed = 100
@export var lower_good_swing_value = 65
@export var upper_good_swing_value = 85

func _ready():
	pick_picture()
	check_for_mods()

func _process(delta):
	if has_swung:
		return
	
	time_elapsed += delta
	if time_elapsed >= total_time:
		# ran out the whole timer without pressing at all
		QTE_Manager.failed_QTE()
		return
	
	# power bar will go up and back down
	if is_holding:
		if hold_value > $PowerSlider.max_value:
			hold_slider_direction = -1
		elif hold_value < $PowerSlider.min_value:
			hold_slider_direction = 1
		
		hold_value += (charge_speed * delta) * hold_slider_direction
		$PowerSlider.value = hold_value

func _input(event): # listening for pressed was more inefficient
	if event.is_action_pressed("swing_hammer"):
		start_hold()
	elif event.is_action_released("swing_hammer"):
		end_hold()

func start_hold():
	is_holding = true
	$PowerSlider.visible = true
	start_idle_vibration()
	pass

func end_hold():
	is_holding = false
	has_swung = true
	idle_tween.kill()  # stop vibration immediately
	$HammerHand/AnimationPlayer.play("swing_hammer")
	await $HammerHand/AnimationPlayer.animation_finished
	check_swing()
	pass

func start_idle_vibration():
	idle_tween = create_tween()
	idle_tween.set_loops()
	idle_tween.tween_property($HammerHand, "rotation", base_rotation + deg_to_rad(idle_vibrate_strength), idle_vibrate_speed)
	idle_tween.tween_property($HammerHand, "rotation", base_rotation - deg_to_rad(idle_vibrate_strength), idle_vibrate_speed)

func check_swing():
	if hold_value >= lower_good_swing_value and hold_value <= upper_good_swing_value:
		$Nail/Particles/RingParticle.emitting = true
		$Nail/Particles/StarsParticle.emitting = true
		$Nail/Particles/BarsParticle.emitting = true
		QTE_Manager.passed_QTE()
		return
	else:
		pass # TODO check this?
		
	if hold_value > upper_good_swing_value: # hit way too hard
		$Nail/Particles/GlassParticle.emitting = true
		$Frame/FrameImage5.visible = true
	
	num_tries -= 1
	if num_tries == 0:
		QTE_Manager.failed_QTE()
	else:
		has_swung = false
		time_elapsed = 0
		hold_value = 0

func redo_me():
	$HammerHand.rotation = base_rotation
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_BACK)

	# wind up but overshoot at a skewed angle
	# like it clipped the nail sideways instead of striking true
	tween.tween_property($HammerHand, "rotation", base_rotation - deg_to_rad(30), 0.1)
	tween.tween_property($HammerHand, "rotation", base_rotation + deg_to_rad(75), 0.12)
	tween.tween_property($HammerHand, "rotation", base_rotation + deg_to_rad(45), 0.08)
	
	num_tries -= 1
	if num_tries == 0:
		QTE_Manager.failed_QTE()
	else:
		tween.kill()
		has_swung = false
		time_elapsed = 0

func check_for_mods():
	var m = QTE_Manager.selected_hammer_nail_mod
	if m == available_modifiers[0]:
		lower_good_swing_value -= 5
		upper_good_swing_value += 5
	elif m == available_modifiers[1]:
		num_tries += 1
	elif m == available_modifiers[2]:
		print("hammer nail mod needs money still") # TODO
		pass

func pick_picture():
	var r = randi_range(1, 4)
	if r == 1:
		$Frame/FrameImage1.visible = true
	if r == 2:
		$Frame/FrameImage2.visible = true
	if r == 3:
		$Frame/FrameImage3.visible = true
	if r == 4:
		$Frame/FrameImage4.visible = true
