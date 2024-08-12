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

func take_damage(_amount: int):
	current_hp -= _amount

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	update_hpbar()
