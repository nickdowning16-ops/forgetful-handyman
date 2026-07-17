class_name QTE
extends Node

# Base event that unique events will inherit from for their overriden logic

@export var available_modifiers: Array[Loop_Mod_Data] = []

@export var time_allowed: float = 10

func get_modifiers():
	return available_modifiers

func _ready():
	pass # override

func _process(delta):
	pass # override

func QTE_success():
	pass # override
	
func QTE_fail():
	pass # override
