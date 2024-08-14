@tool
class_name Hand extends Node2D

signal card_activated(_card: Complete_Card)

@export var hand_radius: float = 200
@export var card_angle: float = -90
@export var angle_limit: float = 25
@export var max_card_spread: float = 5

@onready var test_card = $TestCard
@onready var collision_shape: CollisionShape2D = $DebugShape

var hand: Array = []
var touched: Array = []
var current_card_index: int = -1
#var highlight_index: int = -1

func add_card(_card: Node2D):
	hand.push_back(_card)
	add_child(_card)
	_card.mouse_entered.connect(_handle_card_hovered)
	_card.mouse_exited.connect(_handle_card_unhovered)
	reposition_cards()
	

func _handle_card_hovered(_card):
	touched.push_back(_card)
	#var card_index = hand.find(_card)
	#if highlight_index < card_index:
	#	if highlight_index >= 0:
	#		hand[highlight_index].unhighlight()
	#	highlight_index = card_index
	#print("hovered " + _card.card_name)

func _handle_card_unhovered(_card):
	touched.remove_at(touched.find(_card))
	#var card_index = hand.find(_card)
	#if highlight_index == card_index:
	#	hand[highlight_index].unhighlight()
	#	highlight_index = -1
	#print("unhovered " + _card.card_name)

func remove_card(_index: int) -> Node2D:
	var removed_card = hand[_index]
	hand.remove_at(_index)
	touched.remove_at(touched.find(removed_card))
	remove_child(removed_card)
	reposition_cards()
	return removed_card
	
func remove_card_by_entity(_card: Complete_Card):
	var _remove_index = hand.find(_card)
	remove_card(_remove_index)
	_card.queue_free()
	
	

func empty():
	current_card_index = -1
	for card in hand:
		card.queue_free()
	hand = []
	touched = []

func reposition_cards():
	var card_spread = min(angle_limit / hand.size(), max_card_spread)
	var current_angle = (-(card_spread * (hand.size() - 1) / 2)) - 90
	for card in hand:
		card_transform_update(card, current_angle)
		current_angle += card_spread

func get_card_position(_angle: float):
	var x: float = hand_radius * cos(deg_to_rad(_angle))
	var y: float = hand_radius * sin(deg_to_rad(_angle))
	
	return Vector2(x, y)

func card_transform_update(_card: Node2D, _angle: float):
	_card.set_position(get_card_position(_angle))
	_card.set_rotation(deg_to_rad(90+_angle))

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("left_mouse_click") && current_card_index >= 0:
		var card = hand[current_card_index]
		card_activated.emit(card)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#tool logic
	current_card_index = -1
	for card in hand:
		
		card.unhighlight()
			
	if !touched.is_empty():
		var highest_touched_index: int = -1
		for card in touched:
			highest_touched_index = max(highest_touched_index, hand.find(card))
		if highest_touched_index >= 0 && highest_touched_index < hand.size():
			hand[highest_touched_index].highlight()
			current_card_index = highest_touched_index
	#if highlight_index >= 0 && highlight_index < hand.size():
	#	hand[highlight_index].highlight()
	
	if (collision_shape.shape as CircleShape2D).radius != hand_radius:
		(collision_shape.shape as CircleShape2D).set_radius(hand_radius) 
	
	card_transform_update(test_card, card_angle)
