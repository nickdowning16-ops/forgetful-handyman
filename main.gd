extends Node2D

@onready var choice = %Window

@onready var loop_selector = preload("res://UI/Thought Loops/loop_mod_selector.tscn")
var loop_selector_inst


func _on_problem_area_entered(area: Area2D) -> void:
	#$problem/loop.show()
	#$problem/loop2.show()
	#$problem/loop3.show()
	
	loop_selector_inst = loop_selector.instantiate()
	#get_tree().root.add_child(loop_selector_inst)
	$problem.add_child(loop_selector_inst)

func _on_problem_area_exited(area: Area2D) -> void:
	#$problem/loop.hide()
	#$problem/loop2.hide()
	#$problem/loop3.hide()
	
	loop_selector_inst.queue_free()
