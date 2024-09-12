#extends Node2D
#
#signal card_activated(_card: Complete_Card)
#
#@export var deck: Deck
#
#@onready var strike_card: PackedScene = preload("res://Card Scenes/strike.tscn")
#@onready var dodge_card: PackedScene = preload("res://Card Scenes/dodge.tscn")
#@onready var pin_card: PackedScene = preload("res://Card Scenes/pin.tscn")
#@onready var rip_out_card: PackedScene = preload("res://Card Scenes/rip_out.tscn")
#@onready var fire_card: PackedScene = preload("res://Card Scenes/fire.tscn")
#
#@onready var hand: Hand = $Hand
#
#func remove_card_by_entity(_card: Node2D):
	#$Hand.remove_card_by_entity(_card)
#
#func reset():
	#$Hand.empty()
#
#func send_hand_to_pile(_pile):
	#for card in hand.hand:
		#var _to_add = return_copy(card)
		#_pile.add_card(_to_add)
	#hand.empty()
#
#func draw_from_pile(_pile: Deck, _amount: int):
	#var _ensure = _pile.get_cards().size() - _amount
	#var _to_add
	#for card in _pile.get_cards():
		#if _amount > 0 && _ensure > 0:
			#var _flip = randi_range(0,1)
			#if _flip == 1:
				#_to_add = return_cousin(card)
				#hand.add_card(_to_add)
				#_pile.remove_card(card.id)
				#_amount -= 1
		#elif _amount > 0 && _ensure <=0:
			#_to_add = return_cousin(card)
			#hand.add_card(_to_add)
			#_pile.remove_card(card.id)
			#_amount -= 1
		#_ensure -= 1
#
#func return_copy(_card: Complete_Card) -> Complete_Card:
	#var _copy = strike_card.instantiate()
	#if _copy.get_cost() == _card.get_cost():
		#return _copy
	#else:
		#_copy.queue_free()
		#
	#_copy = dodge_card.instantiate()
	#if _copy.get_cost() == _card.get_cost():
		#return _copy
	#else:
		#_copy.queue_free()
	#
	#_copy = pin_card.instantiate()
	#if _copy.get_cost() == _card.get_cost():
		#return _copy
	#else:
		#_copy.queue_free()
	#
	#_copy = rip_out_card.instantiate()
	#if _copy.get_cost() == _card.get_cost():
		#return _copy
	#else:
		#_copy.queue_free()
	#
	#_copy = fire_card.instantiate()
	#if _copy.get_cost() == _card.get_cost():
		#return _copy
	#else:
		#_copy.queue_free()
	#
	#_copy = strike_card.instantiate()
	#return _copy
#
#func return_cousin(_card: IDCard) -> Complete_Card:
	#var _copy = strike_card.instantiate()
	#if _copy.get_cost() == _card.card.get_cost():
		#return _copy
	#else:
		#_copy.queue_free()
		#
	#_copy = dodge_card.instantiate()
	#if _copy.get_cost() == _card.card.get_cost():
		#return _copy
	#else:
		#_copy.queue_free()
	#
	#_copy = pin_card.instantiate()
	#if _copy.get_cost() == _card.card.get_cost():
		#return _copy
	#else:
		#_copy.queue_free()
		#
	#_copy = rip_out_card.instantiate()
	#if _copy.get_cost() == _card.card.get_cost():
		#return _copy
	#else:
		#_copy.queue_free()
	#
	#_copy = fire_card.instantiate()
	#if _copy.get_cost() == _card.card.get_cost():
		#return _copy
	#else:
		#_copy.queue_free()
	#
	#_copy = strike_card.instantiate()
	#return _copy
#
#func _on_card_spawn_tester_0_pressed():
	#var card = strike_card.instantiate()
	#deck.add_card(card)
	#
	#
	#
#
#
#func _on_card_spawn_tester_1_pressed():
	#var card = dodge_card.instantiate()
	#deck.add_card(card)
	#
	#
#
#
#
#func _on_hand_card_activated(_card):
	#card_activated.emit(_card)
#
#
#func _on_card_destroyer_pressed():
	#if deck.get_cards().is_empty():
		#return
	#var random_card: IDCard = deck.get_cards().pick_random()
	#deck.remove_card(random_card.id)
