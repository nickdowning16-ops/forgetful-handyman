extends Area2D

@export var left_bound = 500
@export var right_bound = 500
@export var top_bound = 500
@export var bottom_bound = 500

var dragging = false
var offset = Vector2(0,0)


func _process(delta: float) -> void:
	if dragging:
		position = get_global_mouse_position() - offset
	if position.x < left_bound:
		position.x = left_bound
	if position.x > right_bound:
		position.x = right_bound
	if position.y > bottom_bound:
		position.y = bottom_bound
	if position.y < top_bound:
		position.y = top_bound



func _on_button_button_down() -> void:
	dragging = true
	offset = get_global_mouse_position() - global_position
	


func _on_button_button_up() -> void:
	dragging = false
