class_name Card extends Node2D

@export var card_name: String = "Card Name"
@export var card_description: String = "Card Description"
@export var card_cost: int = 1
@export var card_cost_resource: Node2D
@export var card_image: Node2D
@export var card_type: Node2D

@onready var name_label: Label = $CardName/NameLbl
@onready var description_label: Label = $CardDescription/DescriptionLbl
@onready var cost_label: Label = $CardCost/CostLbl
@onready var cost_sprite: Sprite2D = $CardCost/CostSpr
@onready var image_sprite: Sprite2D = $CardImage/ImageSpr
@onready var base_sprite: Sprite2D = $CardBase/BaseSpr

func _ready():
	name_label.set_text(card_name)
	description_label.set_text(card_description)
	cost_label.set_text(str(card_cost))

func set_values():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
