extends Node

var progress = 1
var bolts = 0
var bullets = 0
var hp_change = 0

func advance():
	progress += 1

func get_progress() -> int:
	return progress

func add_bolt(_amount):
	bolts += _amount

func get_bolts() -> int:
	return bolts

func add_bullet(_amount):
	bullets += _amount

func get_bullets() -> int:
	return bullets

func change_hp_modifier(_amount):
	hp_change += _amount

func get_hp_modifier() -> int:
	return hp_change
