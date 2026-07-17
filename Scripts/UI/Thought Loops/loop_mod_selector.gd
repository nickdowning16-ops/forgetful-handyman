extends Node

func _ready():
	var mods = QTE_Manager.get_mods()
	$HBoxContainer/LoopMod1.init(mods[0])
	$HBoxContainer/LoopMod2.init(mods[1])
	$HBoxContainer/LoopMod3.init(mods[2])

func _process(delta):
	pass
