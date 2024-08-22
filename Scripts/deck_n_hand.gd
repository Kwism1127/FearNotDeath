extends Node2D

signal card_activated(_card: Complete_Card)

@export var deck: Deck

@onready var strike_card: PackedScene = preload("res://Card Scenes/strike.tscn")
@onready var dodge_card: PackedScene = preload("res://Card Scenes/dodge.tscn")
@onready var hand: Hand = $Hand

func remove_card_by_entity(_card: Node2D):
	$Hand.remove_card_by_entity(_card)

func reset():
	$Hand.empty()

func _on_card_spawn_tester_0_pressed():
	var card = strike_card.instantiate()
	deck.add_card(card)
	
	
	


func _on_card_spawn_tester_1_pressed():
	var card = dodge_card.instantiate()
	deck.add_card(card)
	
	



func _on_hand_card_activated(_card):
	card_activated.emit(_card)


func _on_card_destroyer_pressed():
	if deck.get_cards().is_empty():
		return
	var random_card: IDCard = deck.get_cards().pick_random()
	deck.remove_card(random_card.id)
