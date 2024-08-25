class_name CardContainer extends Container

const CARD_POSITION_OFFSET: Vector2 = Vector2(43, 61)

var card: Complete_Card:
	set(_card):
		card = _card.duplicate()
		card.set_position(CARD_POSITION_OFFSET)
		add_child(card)
