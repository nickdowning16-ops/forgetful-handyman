extends TextureRect


func _input(event: InputEvent) -> void:
	$Toilet.flush()
