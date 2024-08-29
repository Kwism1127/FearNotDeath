@tool
class_name Character extends Node2D

@export var max_hp: int = 10
@export var base_poise: int = 5
@export var starting_bullets: int = 3
@export var starting_bolts: int = 3 


@onready var current_hp: int = max_hp
@onready var poise: int = base_poise
@onready var bullets: int = starting_bullets
@onready var bolts: int = starting_bolts
@onready var pins: int = 0

func _ready():
	if Recorder.get_progress() > 2:
		max_hp += 7
		current_hp += 7
		pins -= 1
		$Sprite.scale.x = .7
		$Sprite.scale.y = .6

func reset():
	current_hp = max_hp
	poise = base_poise
	bullets = starting_bullets
	bolts = starting_bolts
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
