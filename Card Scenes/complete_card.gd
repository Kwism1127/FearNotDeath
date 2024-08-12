class_name Complete_Card extends Node2D

signal mouse_entered(card: Card)
signal mouse_exited(card: Card)


func highlight():
	$Card.highlight()
	
func unhighlight():
	$Card.unhighlight()

func _on_card_mouse_entered(_card: Card):
	mouse_entered.emit(self)

func _on_card_mouse_exited(_card: Card):
	mouse_exited.emit(self)

func activate(_game_state: Dictionary):
	$Function.activate(_game_state)
