class_name QTE
extends Node

# Base event that unique events will inherit from for their overriden logic

@export var time_allowed: float = 10

func _ready():
	pass # override

func _process(delta):
	pass # override

func QTE_success():
	pass # override
	
func QTE_fail():
	pass # override
