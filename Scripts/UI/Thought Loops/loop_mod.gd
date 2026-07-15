extends Node

@export var rise_distance: float = 50.0
@export var fade_duration: float = 0.7

func _ready():
	spawn()
	pass

func _process(delta):
	pass

func _on_area_2d_mouse_entered():
	$Panel/LoopDescription.visible = true
	self.scale = Vector2(1.2, 1.2)

func _on_area_2d_mouse_exited():
	$Panel/LoopDescription.visible = false
	self.scale = Vector2(1.0, 1.0)

func spawn():
	# play anim of moving
	self.modulate.a = 0.0
	self.position.y += rise_distance

	var tween = create_tween()
	tween.set_parallel(true)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_SINE)

	tween.tween_property(self, "modulate:a", 1.0, fade_duration)
	tween.tween_property(self, "position:y", self.position.y - rise_distance, fade_duration)
	
	# play anim of some idle like glow
