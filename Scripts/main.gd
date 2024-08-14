extends Node2D

@onready var game_state: Dictionary = {
	"caster": $GameScreen/PlayerCharacter,
	"targets": [$GameScreen/EnemyCharacter]
}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$GameScreen/PlayerCharacter/PoiseAmount.set_text(str($GameScreen/PlayerCharacter.poise))
	
	#hide enemy poise if not applicable
	if $GameScreen/EnemyCharacter.poise > 0:
		$GameScreen/EnemyCharacter/PoiseAmount.visible = true
		$GameScreen/EnemyCharacter/PoiseIcon.visible = true
		$GameScreen/EnemyCharacter/PoiseAmount.set_text(str($GameScreen/EnemyCharacter.poise))
	else: 
		$GameScreen/EnemyCharacter/PoiseAmount.visible = false
		$GameScreen/EnemyCharacter/PoiseIcon.visible = false
	
func _on_deck_n_hand_card_activated(_card: Complete_Card):
	_card.activate(game_state)



func _on_damage_player_1_pressed():
	$GameScreen/PlayerCharacter.take_damage(1)


func _on_damage_player_3_pressed():
	$GameScreen/PlayerCharacter.take_damage(3)
