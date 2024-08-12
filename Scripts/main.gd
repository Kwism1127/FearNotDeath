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
	$PoiseAmount.set_text(str($GameScreen/PlayerCharacter.poise))


func _on_deck_n_hand_card_activated(_card: Complete_Card):
	_card.activate(game_state)

