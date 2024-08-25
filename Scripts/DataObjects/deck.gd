class_name Deck extends Resource

var card_collection: Dictionary = {}
var id_counter:int = 0

func add_card(_card: Complete_Card):
	var _card_id = _generate_card_id(_card)
	card_collection[_card_id] = IDCard.new(_card_id, _card)
	

func clear():
	card_collection.clear()

func _generate_card_id(_card: Complete_Card) -> int:
	id_counter += 1
	return id_counter

func remove_card(_card_id: int):
	card_collection.erase(_card_id)

func update_card(_card_id: int, _card: Complete_Card):
	card_collection[_card_id].card = _card

func get_cards() -> Array[IDCard]:
	var _cards: Array[IDCard] = [] 
	if !card_collection.is_empty():
		for card in card_collection.values():
			_cards.push_back(card as IDCard)
	return _cards 
