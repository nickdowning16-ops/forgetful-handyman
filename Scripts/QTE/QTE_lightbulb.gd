extends QTE

@export var req_screws = 3
var num_screws = 0

var is_dragging = false
var drag_offset: Vector2 = Vector2.ZERO
var is_seated = false
@onready var bulb : Control = $Lightbulb
@onready var socket : Control = $LightbulbSocket
@export var seat_threshold: float = 0.5
var seat_offset : Vector2 = Vector2(0,100)

@onready var left_zone : Control = $Lightbulb/LeftGrip
@onready var right_zone : Control = $Lightbulb/RightGrip
var is_screwing = false
var in_left = false
var in_right = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if !is_seated:
		if event is InputEventMouseButton:
			if event.pressed:
				is_dragging = true
				drag_offset = bulb.global_position - event.global_position
			else:
				is_dragging = false
	
		elif event is InputEventMouseMotion and is_dragging:
			bulb.global_position = event.global_position + drag_offset
			check_seated()
	
	if event is InputEventMouseButton:
			if event.pressed and in_left:
				is_screwing = true
			elif !event.pressed and in_right and is_screwing:
				check_screws()
				is_screwing = false
			else:
				is_screwing = false
	
	if event is InputEventMouseMotion:
		if left_zone.get_global_rect().has_point(event.position):
			in_left =true
		elif right_zone.get_global_rect().has_point(event.position):
			in_right = true
		else:
			in_left = false
			in_right = false

func check_seated():
	var bulb_rect = bulb.get_global_rect()
	var check_pos = socket.global_position + seat_offset
	var socket_rect = Rect2(check_pos, socket.get_global_rect().size)
	
	var intersection = bulb_rect.intersection(socket_rect)
	if intersection.size == Vector2.ZERO:
		return # not overlapping
	
	var overlap_area = intersection.size.x * intersection.size.y
	var bulb_area = bulb_rect.size.x * bulb_rect.size.y
	
	var overlap_ratio = overlap_area / bulb_area
	
	if overlap_ratio >= seat_threshold:
		on_seated()

func on_seated():
	is_seated = true
	print("seated!")
	# TODO play animation (six grey lines for a click?)
	$"Lightbulb/CPUParticles2D-RM".emitting = true
	$"Lightbulb/CPUParticles2D-RU".emitting = true
	$"Lightbulb/CPUParticles2D-RL".emitting = true
	$"Lightbulb/CPUParticles2D-LM".emitting = true
	$"Lightbulb/CPUParticles2D-LU".emitting = true
	$"Lightbulb/CPUParticles2D-LL".emitting = true
	

func check_screws():
	num_screws += 1
	if num_screws >= req_screws:
		$Lightbulb/LightbulbOffTexture.visible = false
		$Lightbulb/LightbulbOnTexture.visible = true
		# TODO play animation (flash of light)
		# wait for end
		QTE_Manager.passed_QTE()
