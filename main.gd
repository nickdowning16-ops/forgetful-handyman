extends Node2D

@onready var choice = %Window


func _on_problem_area_entered(area: Area2D) -> void:
	$problem/loop.show()
	$problem/loop2.show()
	$problem/loop3.show()


func _on_problem_area_exited(area: Area2D) -> void:
	$problem/loop.hide()
	$problem/loop2.hide()
	$problem/loop3.hide()
