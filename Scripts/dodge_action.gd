extends Node2D

func activate(_game_state: Dictionary):
	_game_state.get("caster").gain_poise(1)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
