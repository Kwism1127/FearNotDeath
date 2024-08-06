class_name Card extends Node2D

@export var card_name: String = "Card Name"
@export var card_description: String = "Card Description"
@export var card_cost: int = 1
@export var card_cost_resource: Sprite2D
@export var card_image: Sprite2D
@export var card_background: Sprite2D

@onready var name_label: Label = $CardName/NameLbl
@onready var description_label: Label = $CardDescription/DescriptionLbl
@onready var cost_label: Label = $CardCost/CostLbl
@onready var cost_sprite: Sprite2D = $CardCost/CostSpr
@onready var image_sprite: Sprite2D = $CardImage/ImageSpr
@onready var base_sprite: Sprite2D = $CardBase/BaseSpr

func _ready():
	set_card_values(card_cost, card_name, card_description)
	

func set_card_values(_cost: int, _name: String, _description: String):
	#_resource: Sprite2D = cost_sprite, _image: Sprite2D = image_sprite, _background: Sprite2D = base_sprite
	
	card_name = _name
	card_description = _description
	card_cost = _cost
	#card_cost_resource = _resource
	#card_image = _image
	#card_background = _background
	
	name_label.set_text(_name)
	description_label.set_text(_description)
	cost_label.set_text(str(_cost))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
