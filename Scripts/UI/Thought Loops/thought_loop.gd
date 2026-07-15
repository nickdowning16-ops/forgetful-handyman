extends Node

func _ready():
	pass

func _process(delta):
	pass

func _on_area_2d_mouse_entered():
	$Panel/LoopDescription.visible = true

func _on_area_2d_mouse_exited():
	$Panel/LoopDescription.visible = false
