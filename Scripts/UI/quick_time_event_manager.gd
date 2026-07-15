extends Node
var QTEUI = preload("res://UI/Scenes/quick_time_event_UI.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# take in an instance of the event to attach?
func open_qte():
	var inst = QTEUI.instantiate()
	get_tree().root.add_child(inst)
