extends Node2D

@onready var strike_card: PackedScene = preload("res://Card Scenes/strike.tscn")
@onready var dodge_card: PackedScene = preload("res://Card Scenes/dodge.tscn")
@onready var hand: Hand = $CanvasLayer/Hand

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_card_spawn_tester_0_pressed():
	var card = strike_card.instantiate()
	hand.add_card(card)
	
	


func _on_card_spawn_tester_1_pressed():
	var card = dodge_card.instantiate()
	hand.add_card(card)
	

