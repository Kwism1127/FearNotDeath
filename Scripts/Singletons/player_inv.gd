extends Node

#---------------------------------------------------------------------------------------------------

var max_hp: int = 10
var current_hp: int = 10
var bolts: int = 3
var bullets: int = 1
var starting_poise: int = 2

#---------------------------------------------------------------------------------------------------

func get_max_hp() -> int:
	return max_hp

func get_current_hp() -> int:
	return current_hp

func get_bolts() -> int:
	return bolts

func get_bullets() -> int:
	return bullets

func get__starting_poise() -> int:
	return starting_poise

#---------------------------------------------------------------------------------------------------

func adjust_max_hp(_amount):
	max_hp += _amount

func adjust_current_hp(_amount):
	current_hp += _amount

func adjust_bolts(_amount):
	bolts += _amount

func adjust_bullets(_amount):
	bullets += _amount

func adjust_starting_poise(_amount):
	starting_poise += _amount

#---------------------------------------------------------------------------------------------------

func set_max_hp(_amount):
	max_hp = _amount

func set_current_hp(_amount):
	current_hp = _amount

func set_bolts(_amount):
	bolts = _amount

func set_bullets(_amount):
	bullets = _amount

func set_starting_poise(_amount):
	starting_poise = _amount
