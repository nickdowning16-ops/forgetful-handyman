extends Node2D

@onready var loop_selector = preload("res://UI/Thought Loops/loop_mod_selector.tscn")
var loop_selector_inst

#region Show Rooms
func _on_front_area_entered(area: Area2D) -> void:
	$RoomCovers/Front.hide()

func _on_mid_left_area_entered(area: Area2D) -> void:
	$RoomCovers/MidLeft.hide()

func _on_mid_right_area_entered(area: Area2D) -> void:
	$RoomCovers/MidRight.hide()

func _on_back_area_entered(area: Area2D) -> void:
	$RoomCovers/Back.hide()
#endregion

#region Problems
var in_picture_problem_area = false # otherwise it just keeps spawning it
func _on_problem_picture_area_entered(area):
	if in_picture_problem_area == false:
		loop_selector_inst = loop_selector.instantiate()
		loop_selector_inst.init(QTE_Manager.get_hammer_nail_mods())
		$Problems/ProblemPicture.add_child(loop_selector_inst)
	in_picture_problem_area = true

func _on_problem_picture_area_exited(area):
	if in_picture_problem_area:
		loop_selector_inst.queue_free()
	in_picture_problem_area = false

var in_lightbulb_problem_area = false
func _on_problem_lightbulb_area_entered(area):
	if in_lightbulb_problem_area == false:
		loop_selector_inst = loop_selector.instantiate()
		loop_selector_inst.init(QTE_Manager.get_lightbulb_mods())
		$Problems/ProblemLightbulb.add_child(loop_selector_inst)
	in_lightbulb_problem_area = true

func _on_problem_lightbulb_area_exited(area):
	if in_lightbulb_problem_area:
		loop_selector_inst.queue_free()
	in_lightbulb_problem_area = false

## (assuming) all problems have been checked when you entered here, maybe check to see if
## all selected mods in manager are not null?
func _on_problems_checked_area_entered(area):
	$Problems/ProblemLightbulb.monitoring = false
	$Problems/ProblemPicture.monitoring = false
	$Problems/ProblemToilet.monitoring = false
	$QTEs/QTELightbulb.monitoring = true
	$QTEs/QTEPicture.monitoring = true
	$QTEs/QTEToilet.monitoring = true
#endregion

#region QTEs
func _on_qte_lightbulb_area_entered(area):
	QTE_Manager.open_QTE($QTECanvasLayer, QTE_Manager.get_lightbulb_preload())

func _on_qte_picture_area_entered(area):
	QTE_Manager.open_QTE($QTECanvasLayer, QTE_Manager.get_hammer_nail_preload())
#endregion
