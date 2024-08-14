@tool
class_name Character extends Node2D

@export var max_hp: int = 10
@export var current_hp: int = 10
@export var poise: int = 5

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

func gain_poise(_amount: int):
	poise += _amount 
	if poise > max_hp:
		poise = max_hp

func take_damage(_amount: int):
	if _amount <= poise:
		poise -= _amount
	elif _amount > poise:
		var _damage: int = _amount - poise
		poise = 0
		current_hp -= _damage

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	update_hpbar()
