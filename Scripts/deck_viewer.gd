extends ScrollContainer

@onready var card_container_scn: PackedScene = preload("res://UI Scenes/card_container.tscn")
@onready var flow_container = $HFlowContainer

func display_card_list(_cards: Array[Complete_Card]):
	for card in _cards:
		var card_container: CardContainer = card_container_scn.instantiate() as CardContainer
		card_container.card = card
		flow_container.add_child(card_container)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
