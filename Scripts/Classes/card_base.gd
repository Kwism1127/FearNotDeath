class_name CardBase extends Node2D

#---------------------------------------------------------------------------------------------------
#Class variables

@onready var base_sprite: Texture2D = $BaseSprite.texture
@onready var card_art: Texture2D = $CardArt.texture
@onready var primary_resource_art: Texture2D = $Cost/PrimaryResource.texture
@onready var secondary_resource_art: Texture2D = $Cost/SecondaryResource.texture

@onready var card_name: String = $CardTitle.text
@onready var card_description: String = $CardText.text
@onready var cost_primary_amount: int = int($Cost/PrimaryCost.text)
@onready var cost_secondary_amount: int = int($Cost/SecondaryCost.text)

@onready var dual_cost: bool = false
@onready var ID: int = 0

#---------------------------------------------------------------------------------------------------
#Class functions

#initialization
func _ready():
	#Alters appearence if not a dual resource card
	#!!!!!This is not currently revertable!!!!!
	if !dual_cost:
		#Determine the correct position
		var icon_position = $Cost/SecondaryResource.get_position()
		var label_position = $Cost/SecondaryCost. get_position()
		icon_position.x += 15
		label_position.x += 15
		
		#Set the position and hide unused cost label & icon
		$Cost/PrimaryResource.set_position(icon_position)
		$Cost/PrimaryCost.set_position(label_position)
		$Cost/SecondaryResource.visible = false
		$Cost/SecondaryCost.visible = false

#updates
func _process(_delta):
	_update_graphics()

#Goes through each player visible attribute and ensures what the player sees is what the card stores
func _update_graphics():
	if base_sprite != $BaseSprite.texture:
		$BaseSprite.texture = base_sprite
	if card_art != $CardArt.texture:
		$CardArt.texture = card_art
	if primary_resource_art != $Cost/PrimaryResource.texture:
		$Cost/PrimaryResource.texture = primary_resource_art
	if secondary_resource_art != $Cost/SecondaryResource.texture:
		$Cost/SecondaryResource.texture = secondary_resource_art
	if card_name != $CardTitle.text:
		$CardTitle.text = card_name
	if card_description != $CardText.text:
		$CardText.text = card_description
	if cost_primary_amount != int($Cost/PrimaryCost.text):
		$Cost/PrimaryCost.text = str(cost_primary_amount)
	if cost_secondary_amount != int($Cost/SecondaryCost.text):
		$Cost/SecondaryCost.text = str(cost_secondary_amount)

#-------------------------------------------------------------------------------
#Setters

func set_base(_spr_texture: Texture2D):
	base_sprite = _spr_texture

func set_art(_spr_texture: Texture2D):
	card_art = _spr_texture

#!!!!!This will result in a visual bug due to the energy icon being larger than the other icons!!!!!
func set_pri_resource(_spr_texture: Texture2D):
	primary_resource_art = _spr_texture

func set_sec_resource(_spr_texture: Texture2D):
	secondary_resource_art = _spr_texture

func set_title(_name: String):
	card_name = _name

func set_text(_text: String):
	card_description = _text

func set_pri_cost(_cost: int):
	cost_primary_amount = _cost

func set_sec_cost(_cost: int):
	cost_secondary_amount = _cost

func set_dual_bool(_bool: bool):
	dual_cost = _bool

func set_ID(_id: int):
	ID = _id

#-------------------------------------------------------------------------------
#Getters

func get_base() -> Texture2D:
	return base_sprite

func get_art() -> Texture2D:
	return card_art

func get_pri_resource() -> Texture2D:
	return primary_resource_art

func get_sec_resource() -> Texture2D:
	return secondary_resource_art

func get_title() -> String:
	return card_name

func get_text() -> String:
	return card_description

func get_pri_cost() -> int:
	return cost_primary_amount

func get_sec_cost() -> int:
	return cost_secondary_amount

func get_dual_bool() -> bool:
	return dual_cost

func get_ID() -> int:
	return ID
