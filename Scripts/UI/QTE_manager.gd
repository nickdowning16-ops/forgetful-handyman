extends Node
var QTEUI = preload("res://UI/Scenes/QTE_UI.tscn")
var QTE_inst

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

# take in an instance of the event to attach?
func open_QTE():
	QTE_inst = QTEUI.instantiate()
	get_tree().root.add_child(QTE_inst)
	QTE_inst.init(10)

func complete_QTE():
	QTE_inst.queue_free()
