extends Node2D

#@onready var choice = %Window

@onready var loop_selector = preload("res://UI/Thought Loops/loop_mod_selector.tscn")
var loop_selector_inst

var in_area = false
func _on_problem_area_entered(area: Area2D) -> void:
	#$problem/loop.show()
	#$problem/loop2.show()
	#$problem/loop3.show()
	if in_area == false:
		loop_selector_inst = loop_selector.instantiate()
		#get_tree().root.add_child(loop_selector_inst)
		$problem.add_child(loop_selector_inst)
	in_area = true

func _on_problem_area_exited(area: Area2D) -> void:
	#$problem/loop.hide()
	#$problem/loop2.hide()
	#$problem/loop3.hide()
	if in_area:
		loop_selector_inst.queue_free()
	in_area = false

func _on_qte_spawner_area_entered(area):
	print("hi")
	QTE_Manager.open_QTE($CanvasLayer)

func _on_front_area_entered(area: Area2D) -> void:
	$RoomCovers/Front.hide()

func _on_mid_left_area_entered(area: Area2D) -> void:
	$RoomCovers/MidLeft.hide()

func _on_mid_right_area_entered(area: Area2D) -> void:
	$RoomCovers/MidRight.hide()

func _on_back_area_entered(area: Area2D) -> void:
	$RoomCovers/Back.hide()
