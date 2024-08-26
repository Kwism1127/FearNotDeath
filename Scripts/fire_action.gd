extends Node2D


func activate(_game_state: Dictionary):
	_game_state.get("caster").spend_bullet(1)
	_game_state.get("targets")[0].take_damage(6)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
