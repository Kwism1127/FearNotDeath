extends Node2D


func activate(_game_state: Dictionary):
	_game_state.get("caster").spend_poise(1)
	if _game_state.get("targets")[0].pins > 0:
		_game_state.get("targets")[0].take_damage(2)
		_game_state.get("targets")[0].pins -= 1
		_game_state.get("caster").bolts += 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


