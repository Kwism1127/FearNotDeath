extends Node

var progress = 1

func advance():
	progress += 1

func get_progress() -> int:
	return progress

