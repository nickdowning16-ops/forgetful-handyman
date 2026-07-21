extends Node
var QTEUI = preload("res://UI/Scenes/QTE_UI.tscn")
var temp_QTE = preload("res://Scenes/QTEs/QTE_hammer_nail.tscn")
var QTE_inst

#region Internal Functions
func _ready():
	assign_mods()

func _process(delta):
	pass
#endregion

#region Mods
# TODO need a way to prevent mod_selector from reopening after chosen (ask this script if mod is null?)
var hammer_nail_modifiers: Array[Loop_Mod_Data] = []
var selected_hammer_nail_mod

func get_mods():
	# either select X amount of random events through this and return them then build the level
	# or the level is prebuilt and knows which QTEs it wants and we'll create getters for each
	# ideally we wouldnt need a list of mods here, and kept on the QTE, but we cant pull the resources before instantiating (unless...)
	return hammer_nail_modifiers

func get_selected_hammer_nail_mod(): return selected_hammer_nail_mod
func set_selected_hammer_nail_mod(mod): 
	selected_hammer_nail_mod = mod
	update_loop_UI()

# assign others here as well
func assign_mods():
	hammer_nail_modifiers = [
		preload("res://Scripts/UI/Thought Loops/Hammer_Nail/hammer_nail_mod1.tres"),
		preload("res://Scripts/UI/Thought Loops/Hammer_Nail/hammer_nail_mod2.tres"),
		preload("res://Scripts/UI/Thought Loops/Hammer_Nail/hammer_nail_mod3.tres")
	]

# a loop was chosen, add it in order to the UI
func update_loop_UI():
	pass
#endregion

#region QTE
func open_QTE(parentUI):
	QTE_inst = QTEUI.instantiate()
	parentUI.add_child(QTE_inst)
	QTE_inst.init(10)
	
	# TEMP
	QTE_inst.get_event_container().add_child(temp_QTE.instantiate())

func passed_QTE():
	await get_tree().create_timer(1).timeout
	QTE_inst.end(true)
	await get_tree().create_timer(3).timeout
	complete_QTE()
	pass

func failed_QTE():
	await get_tree().create_timer(1).timeout
	QTE_inst.end(false)
	await get_tree().create_timer(3).timeout
	Game_Manager.lose_life()
	complete_QTE()
	pass

func complete_QTE():
	QTE_inst.queue_free()
#endregion
