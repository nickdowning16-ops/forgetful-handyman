extends Node
var QTEUI = preload("res://UI/Scenes/QTE_UI.tscn")
var QTE_hammer_nail = preload("res://Scenes/QTEs/QTE_hammer_nail.tscn")
var QTE_lightbulb = preload("res://Scenes/QTEs/QTE_lightbulb.tscn")
var QTE_UI_inst

#region Internal Functions
func _ready():
	assign_mods()

func _process(delta):
	pass
#endregion

#region Mods
# TODO need a way to prevent mod_selector from reopening after chosen (ask this script if mod is null?)
var hammer_nail_modifiers: Array[Loop_Mod_Data] = []
var lightbulb_modifiers: Array[Loop_Mod_Data] = []
var selected_hammer_nail_mod
var selected_lightbulb_mod

# either select X amount of random events through this and return them then build the level
# or the level is prebuilt and knows which QTEs it wants and we'll create getters for each
# ideally we wouldnt need a list of mods here, and kept on the QTE, but we cant pull the resources before instantiating (unless...)
func get_hammer_nail_mods():
	return hammer_nail_modifiers
func get_lightbulb_mods():
	return lightbulb_modifiers

func set_mod(mod : Loop_Mod_Data):
	if mod.id == "hammer_nail":
		set_selected_hammer_nail_mod(mod)
	elif mod.id == "lightbulb":
		set_selected_lightbulb_mod(mod)

func get_selected_hammer_nail_mod(): return selected_hammer_nail_mod
func set_selected_hammer_nail_mod(mod): 
	selected_hammer_nail_mod = mod
	update_loop_UI()
func get_selected_lightbulb_mod(): return selected_lightbulb_mod
func set_selected_lightbulb_mod(mod): 
	selected_lightbulb_mod = mod
	update_loop_UI()

# assign others here as well
func assign_mods():
	hammer_nail_modifiers = [
		preload("res://Scripts/UI/Thought Loops/Hammer_Nail/hammer_nail_mod1.tres"),
		preload("res://Scripts/UI/Thought Loops/Hammer_Nail/hammer_nail_mod2.tres"),
		preload("res://Scripts/UI/Thought Loops/Hammer_Nail/hammer_nail_mod3.tres")
	]
	lightbulb_modifiers = [
		preload("res://Scripts/UI/Thought Loops/Lightbulb/lightbulb_mod1.tres"),
		preload("res://Scripts/UI/Thought Loops/Lightbulb/lightbulb_mod2.tres"),
		preload("res://Scripts/UI/Thought Loops/Lightbulb/lightbulb_mod3.tres")
	]

# a loop was chosen, add it in order to the UI
func update_loop_UI():
	pass # TODO
#endregion

#region QTE
func get_hammer_nail_preload():
	return QTE_hammer_nail
func get_lightbulb_preload():
	return QTE_lightbulb

func open_QTE(parentUI, selected_QTE):
	QTE_UI_inst = QTEUI.instantiate()
	parentUI.add_child(QTE_UI_inst)
	QTE_UI_inst.init(10) # TODO magic 10 seconds - change to something else
	
	QTE_UI_inst.get_event_container().add_child(selected_QTE.instantiate())

func passed_QTE():
	await get_tree().create_timer(1).timeout
	QTE_UI_inst.end(true)
	await get_tree().create_timer(3).timeout
	complete_QTE()
	pass

func failed_QTE():
	await get_tree().create_timer(1).timeout
	QTE_UI_inst.end(false)
	await get_tree().create_timer(3).timeout
	Game_Manager.lose_life()
	complete_QTE()
	pass

func complete_QTE():
	QTE_UI_inst.queue_free()
#endregion
