class_name Card extends Node2D

@export var card_name: String = "Card Name"
@export var card_description: String = "Card Description"
@export var card_cost: int = 1
@export var card_cost_resource: Texture2D
@export var card_image: Texture2D
@export var card_background: Texture2D

@onready var name_label: Label = $CardName/NameLbl
@onready var description_label: Label = $CardDescription/DescriptionLbl
@onready var cost_label: Label = $CardCost/CostLbl
@onready var cost_sprite: Sprite2D = $CardCost/CostSpr
@onready var image_sprite: Sprite2D = $CardImage/ImageSpr
@onready var base_sprite: Sprite2D = $CardBase/BaseSpr

func _ready():
	set_card_values(card_cost, card_name, card_description, card_cost_resource, card_image, card_background)
	

func set_card_values(_cost: int, _name: String, _description: String, _resource: Texture2D, _image: Texture2D, _background: Texture2D):
	
	card_name = _name
	card_description = _description
	card_cost = _cost
	card_cost_resource = _resource
	card_image = _image
	card_background = _background
	
	name_label.set_text(_name)
	description_label.set_text(_description)
	cost_label.set_text(str(_cost))
	cost_sprite.texture = _resource
	image_sprite.texture = _image
	base_sprite.texture = _background
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
