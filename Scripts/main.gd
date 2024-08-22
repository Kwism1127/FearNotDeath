extends Node2D

@onready var game_manager: Game_Manager = $GameManager
@onready var game_state: Dictionary = {
	"caster": $GameScreen/PlayerCharacter,
	"targets": [$GameScreen/EnemyCharacter]
}

@onready var deck: Deck = Deck.new()

var enemy_state: int = 0
var deck_viewer_toggle: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$DeckNHand.deck = deck

func restart_game():
	game_manager.current_state = Game_Manager.GameState.PLAYER_TURN
	$GameScreen/PlayerCharacter.reset()
	$GameScreen/EnemyCharacter.reset()
	$DeckNHand.reset()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if !game_manager.is_running:
		return
	
	$GameScreen/PlayerCharacter/PoiseAmount.set_text(str($GameScreen/PlayerCharacter.poise))
	
	if $GameScreen/PlayerCharacter.current_hp <= 0:
		game_manager.current_state = Game_Manager.GameState.GAMEOVER
	elif $GameScreen/EnemyCharacter.current_hp <= 0:
		game_manager.current_state = Game_Manager.GameState.VICTORY
	
	#hide enemy poise if not applicable
	if $GameScreen/EnemyCharacter.poise > 0:
		$GameScreen/EnemyCharacter/PoiseAmount.visible = true
		$GameScreen/EnemyCharacter/PoiseIcon.visible = true
		$GameScreen/EnemyCharacter/PoiseAmount.set_text(str($GameScreen/EnemyCharacter.poise))
	else: 
		$GameScreen/EnemyCharacter/PoiseAmount.visible = false
		$GameScreen/EnemyCharacter/PoiseIcon.visible = false
	
	$GameScreen/EnemyCharacter/AIState.set_text(str(enemy_state))
	if game_manager.current_state == Game_Manager.GameState.ENEMY_TURN:
		if enemy_state == 0:
			$GameScreen/EnemyCharacter.gain_poise(3)
		elif enemy_state == 1:
			$GameScreen/EnemyCharacter.gain_poise(1)
			$GameScreen/PlayerCharacter.take_damage(1)
		elif enemy_state == 2:
			if $GameScreen/EnemyCharacter.poise >= 2:
				$GameScreen/EnemyCharacter.spend_poise(2)
				$GameScreen/PlayerCharacter.take_damage(5)
		
		#random behavior
		#enemy_state = randi_range(0,2)
		#cyclical behavior
		enemy_state = posmod(enemy_state + 1, 3)
		game_manager.transition_state(Game_Manager.GameState.PLAYER_TURN)
	
	if game_manager.current_state == Game_Manager.GameState.VICTORY:
		$CanvasLayer/VICTORY.visible = true
	else:
		$CanvasLayer/VICTORY.visible = false
	
	if game_manager.current_state == Game_Manager.GameState.GAMEOVER:
		$CanvasLayer/GAMEOVER.visible = true
	else:
		$CanvasLayer/GAMEOVER.visible = false
	
func _on_deck_n_hand_card_activated(_card: ):
	var _cost_package = _card.get_cost()
	var _resource: String = _cost_package[0]
	var _cost: int = _cost_package[1]
	
	if _resource == "Poise":
		if _cost <= $GameScreen/PlayerCharacter.poise:
			_card.activate(game_state)
			$DeckNHand.remove_card_by_entity(_card)
		else:
			pass
	elif _resource == "Hp":
		if _cost <= $GameScreen/PlayerCharacter.current_hp:
			_card.activate(game_state)
			$DeckNHand.remove_card_by_entity(_card)
		else:
			pass
	elif _resource == "Bullets":
		if _cost <= $GameScreen/PlayerCharacter.bullets:
			_card.activate(game_state)
			$DeckNHand.remove_card_by_entity(_card)
		else:
			pass
	elif _resource == "Bolts":
		if _cost <= $GameScreen/PlayerCharacter.bolts:
			_card.activate(game_state)
			$DeckNHand.remove_card_by_entity(_card)
		else:
			pass
	else:
		if _cost <= $GameScreen/PlayerCharacter.poise:
			_card.activate(game_state)
			$DeckNHand.remove_card_by_entity(_card)
		
		else:
			pass
	
	

func _input(event):
	if event.is_action_pressed("restart"):
		restart_game()

func _on_end_turn_button_pressed():
	if game_manager.current_state == Game_Manager.GameState.PLAYER_TURN:
		game_manager.transition_state(Game_Manager.GameState.ENEMY_TURN)



func _on_show_deck_pressed():
	if deck_viewer_toggle == 0:
		game_manager.pause()
		$CanvasLayer/DeckViewer.visible = true
		$CanvasLayer/DeckViewerBackground.visible = true
		$CanvasLayer/DeckViewer.display_card_list(deck.get_cards())
		deck_viewer_toggle = 1
	else:
		game_manager.unpause()
		$CanvasLayer/DeckViewer.visible = false
		$CanvasLayer/DeckViewerBackground.visible = false
		deck_viewer_toggle = 0

func _on_menu_button_pressed():
	$CanvasLayer/MenuOverlay.visible = !$CanvasLayer/MenuOverlay.visible
	game_manager.is_running = !game_manager.is_running


func _on_restart_pressed():
	$CanvasLayer/GAMEOVER.visible = false
	$CanvasLayer/VICTORY.visible = false
	restart_game()


func _on_return_2_menu_pressed():
	get_tree().change_scene_to_file("res://UI Scenes/main_menu.tscn")


func _on_quit_pressed():
	get_tree().quit()
