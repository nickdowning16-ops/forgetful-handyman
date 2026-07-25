extends Control

var flush_chance = 25
var dragging = false


func _process(delta: float) -> void:
	if dragging:
			%BottomPlunge.show()


func _on_bottom_plunge_area_entered(area: Area2D) -> void:
	if flush_chance < 100:
		flush_chance += 5
	$Splash.emitting = true
	$FlushChance.text = "Flush Chance: " + str(flush_chance) + "%"

func _on_bottom_plunge_area_exited(area: Area2D) -> void:
	$Splash.emitting = false

func flush():
	var chance = randi() % 100
	if flush_chance > chance:
		print("that boy flushed") 
		QTE_Manager.passed_QTE()
	else:
		print("you done flooded the bathroom. What is wrong with you")
		QTE_Manager.failed_QTE()

func _on_button_button_down() -> void:
	dragging = true

func _on_button_button_up() -> void:
	dragging = false

func _on_flush_pressed() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($ToiletFull/FlushHandle, "rotation_degrees", -30.0, 0.2).set_ease(Tween.EASE_OUT)
	tween.tween_interval(0.5)
	tween.tween_property($ToiletFull/FlushHandle, "rotation_degrees", 0.0, 0.5).set_ease(Tween.EASE_IN_OUT)
	flush()
