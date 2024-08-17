class_name Deck extends RefCounted

var card_collection: Dictionary = {}
var id_counter:int = 0

func add_card(_card: Complete_Card):
	var _card_id = _generate_card_id(_card)
	card_collection[_card_id] = IDCard.new(_card_id, _card)
	

func _generate_card_id(_card: Complete_Card) -> int:
	++id_counter
	return id_counter

func remove_card(_card_id: int):
	card_collection.erase(_card_id)

func update_card(_card_id: int, _card: Complete_Card):
	card_collection[_card_id].card = _card

func get_cards() -> Array[IDCard]:
	return card_collection.values()
