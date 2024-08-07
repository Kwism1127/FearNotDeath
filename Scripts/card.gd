@tool
class_name Card extends Node2D

signal mouse_entered(card: Card)
signal mouse_exited(card: Card)
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
	

func _update_graphics():
	if name_label.get_text() != card_name:
		name_label.set_text(card_name)
	if description_label.get_text() != card_description:
		description_label.set_text(card_description)
	if cost_label.get_text() != str(card_cost):
		cost_label.set_text(str(card_cost))
	if cost_sprite.texture != card_cost_resource:
		cost_sprite.texture = card_cost_resource
	if image_sprite.texture != card_image:
		image_sprite.texture = card_image
	if base_sprite.texture != card_background:
		base_sprite.texture = card_background

func set_card_values(_cost: int, _name: String, _description: String, _resource: Texture2D, _image: Texture2D, _background: Texture2D):
	
	card_name = _name
	card_description = _description
	card_cost = _cost
	card_cost_resource = _resource
	card_image = _image
	card_background = _background
	
	_update_graphics()
	
	
	
func highlight():
	base_sprite.set_modulate(Color(1,0,0,1))
	
func unhighlight():
	base_sprite.set_modulate(Color(1,1,1,1))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_update_graphics()
	


func _on_area_2d_mouse_entered():
	mouse_entered.emit(self)


func _on_area_2d_mouse_exited():
	mouse_exited.emit(self)



func _on_area_2d_input_event(viewport, event, shape_idx):
	pass # Replace with function body.
