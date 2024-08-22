extends ScrollContainer

@onready var card_container_scn: PackedScene = preload("res://UI Scenes/card_container.tscn")
@onready var flow_container = $HFlowContainer

var cached_container: Array[CardContainer] = []

func clear_display():
	for child in flow_container.get_children():
		child.remove_child(child.card)
		flow_container.remove_child(child)

func display_card_list(_cards: Array[IDCard]):
	clear_display()
	while cached_container.size() < _cards.size():
		cached_container.push_back(card_container_scn.instantiate() as CardContainer)
	
	for i in _cards.size():
		var idcard: IDCard = _cards[i] as IDCard
		var card_container: CardContainer = cached_container[i]
		card_container.card = idcard.card
		flow_container.add_child(card_container)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
