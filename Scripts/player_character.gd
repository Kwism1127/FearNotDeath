#@tool
class_name PlayerCharacter extends Node2D

@onready var import_max_hp: int = PlayerInv.get_max_hp()
@onready var import_current_hp: int = PlayerInv.get_current_hp()
@onready var import_base_poise: int = PlayerInv.get__starting_poise()
@onready var import_starting_bullets: int = PlayerInv.get_bullets()
@onready var import_starting_bolts: int = PlayerInv.get_bolts()


@onready var max_hp: int = import_max_hp
@onready var current_hp: int = import_current_hp
@onready var poise: int = import_base_poise
@onready var bullets: int = import_starting_bullets
@onready var bolts: int = import_starting_bolts
@onready var pins: int = 0

func reset():
	max_hp = import_max_hp
	current_hp = import_current_hp
	poise = import_base_poise
	bullets = import_starting_bullets
	bolts = import_starting_bolts
	pins = 0
	

func set_hp(_max: int, _current: int):
	max_hp = _max
	current_hp = _current
	
func update_hpbar():
	if ($Healthbar as ProgressBar).max_value != max_hp:
		($Healthbar as ProgressBar).max_value = max_hp
	if ($Healthbar as ProgressBar).value != current_hp:
		($Healthbar as ProgressBar).value = current_hp

func spend_poise(_amount: int):
	poise -= _amount
	
func spend_bolt(_amount: int):
	bolts -= _amount

func spend_bullet(_amount: int):
	bullets -= _amount

func pin(_amount: int):
	pins += _amount

func gain_poise(_amount: int):
	poise += _amount 
	if poise > max_hp:
		poise = max_hp

func take_damage(_amount: int):
	if _amount <= poise:
		spend_poise(_amount)
	elif _amount > poise:
		var _damage: int = _amount - poise
		poise = 0
		current_hp -= _damage

func enemy_attack_animation() -> Vector2:
	var starting_pos: Vector2 = $Sprite.global_position
	var move: Vector2 = Vector2(starting_pos.x - 20, starting_pos.y + 7)
	$Sprite.global_position = move
	
	return starting_pos

func reset_pos(_starting_pos: Vector2):
	$Sprite.global_position = _starting_pos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	update_hpbar()
