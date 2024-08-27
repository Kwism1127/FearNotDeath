extends Node2D

@onready var game_manager: Game_Manager = $GameManager
@onready var game_state: Dictionary = {
	"caster": $GameScreen/PlayerCharacter,
	"targets": [$GameScreen/EnemyCharacter]
}

@onready var deck: Deck = Deck.new()
@onready var discard_pile: Deck = Deck.new()

var enemy_state: int = 0
var deck_viewer_toggle: int = 0
var discard_viewer_toggle: int = 0
var wait: float = .25
var position_holder: Vector2 = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	$DeckNHand.deck = deck
	var _card
	
	var _i = 0
	while _i < 8:
		$CanvasLayer/DeckViewer.clear_display()
		_card = $DeckNHand.strike_card.instantiate()
		deck.add_card(_card)
		_i += 1
	
	_i = 0
	while _i < 4:
		$CanvasLayer/DeckViewer.clear_display()
		_card = $DeckNHand.dodge_card.instantiate()
		deck.add_card(_card)
		_i += 1
	
	_i = 0
	while _i < 3:
		$CanvasLayer/DeckViewer.clear_display()
		_card = $DeckNHand.pin_card.instantiate()
		deck.add_card(_card)
		_i += 1
	
	_i = 0
	while _i < 3:
		$CanvasLayer/DeckViewer.clear_display()
		_card = $DeckNHand.rip_out_card.instantiate()
		deck.add_card(_card)
		_i += 1
	
	_i = 0
	while _i < 2:
		$CanvasLayer/DeckViewer.clear_display()
		_card = $DeckNHand.fire_card.instantiate()
		deck.add_card(_card)
		_i += 1
	
	$CanvasLayer/DeckViewer.clear_display()
	$DeckNHand.draw_from_pile(deck, 4)


func restart_game():
	game_manager.current_state = Game_Manager.GameState.PLAYER_TURN
	$GameScreen/PlayerCharacter.reset()
	$GameScreen/EnemyCharacter.reset()
	$DeckNHand.send_hand_to_pile(discard_pile)
	for card in discard_pile.get_cards():
		deck.add_card(card.card)
		discard_pile.clear()
	$DeckNHand.reset()
	$DeckNHand.draw_from_pile(deck, 4)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if !game_manager.is_running:
		return
	
	$GameScreen/PlayerCharacter/PoiseAmount.set_text(str($GameScreen/PlayerCharacter.poise))
	$GameScreen/PlayerCharacter/BoltsAmount.set_text(str($GameScreen/PlayerCharacter.bolts))
	$GameScreen/PlayerCharacter/BulletsAmount.set_text(str($GameScreen/PlayerCharacter.bullets))
	
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
	
	if $GameScreen/EnemyCharacter.pins > 0:
		$GameScreen/EnemyCharacter/PinnedAmount.visible = true
		$GameScreen/EnemyCharacter/PinnedIcon.visible = true
		$GameScreen/EnemyCharacter/PinnedAmount.set_text(str($GameScreen/EnemyCharacter.pins))
	else: 
		$GameScreen/EnemyCharacter/PinnedAmount.visible = false
		$GameScreen/EnemyCharacter/PinnedIcon.visible = false

#---------------------------------------------------------------------------------------------------
#enemy action

	$GameScreen/EnemyCharacter/AIState.set_text(str(enemy_state))
	if game_manager.current_state == Game_Manager.GameState.ENEMY_TURN:
		if enemy_state == 0:
			if $GameScreen/EnemyCharacter.poise < 10:
				$GameScreen/EnemyCharacter.gain_poise(3)
		elif enemy_state == 1:
			$GameScreen/EnemyCharacter.gain_poise(1)
			$GameScreen/PlayerCharacter.take_damage(2)
			$CanvasLayer/PlayerDamaged.visible = true
			position_holder = $GameScreen/EnemyCharacter.enemy_attack_animation()
			$CanvasLayer/PlayerDamaged/Holder.start(wait)
		elif enemy_state == 2:
			if $GameScreen/EnemyCharacter.poise >= 2:
				$GameScreen/EnemyCharacter.spend_poise(2)
				$GameScreen/PlayerCharacter.take_damage(6)
				$CanvasLayer/PlayerDamaged.visible = true
				position_holder = $GameScreen/EnemyCharacter.enemy_attack_animation()
				$CanvasLayer/PlayerDamaged/Holder.start(wait)
		#random behavior
		#enemy_state = randi_range(0,2)
		#cyclical behavior
		enemy_state = posmod(enemy_state + 1, 3)
		game_manager.transition_state(Game_Manager.GameState.PLAYER_TURN)
		if deck.get_cards().size() > 0:
			$DeckNHand.draw_from_pile(deck, 4)
		else:
			for card in discard_pile.get_cards():
				deck.add_card(card.card)
			discard_pile.clear()
			$DeckNHand.draw_from_pile(deck, 4)
		$GameScreen/PlayerCharacter.gain_poise(1)

#---------------------------------------------------------------------------------------------------

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
			var _copy = $DeckNHand.return_copy(_card)
			discard_pile.add_card(_copy)
			$DeckNHand.remove_card_by_entity(_card)
		else:
			pass
	elif _resource == "Hp":
		if _cost <= $GameScreen/PlayerCharacter.current_hp:
			_card.activate(game_state)
			var _copy = $DeckNHand.return_copy(_card)
			discard_pile.add_card(_copy)
			$DeckNHand.remove_card_by_entity(_card)
		else:
			pass
	elif _resource == "Bullets":
		if _cost <= $GameScreen/PlayerCharacter.bullets:
			_card.activate(game_state)
			var _copy = $DeckNHand.return_copy(_card)
			discard_pile.add_card(_copy)
			$DeckNHand.remove_card_by_entity(_card)
		else:
			pass
	elif _resource == "Bolts":
		if _cost <= $GameScreen/PlayerCharacter.bolts:
			_card.activate(game_state)
			var _copy = $DeckNHand.return_copy(_card)
			discard_pile.add_card(_copy)
			$DeckNHand.remove_card_by_entity(_card)
		else:
			pass
	else:
		if _cost <= $GameScreen/PlayerCharacter.poise:
			_card.activate(game_state)
			var _copy = $DeckNHand.return_copy(_card)
			discard_pile.add_card(_copy)
			$DeckNHand.remove_card_by_entity(_card)
		
		else:
			pass
	
	

func _input(event):
	if event.is_action_pressed("restart"):
		restart_game()

func _on_end_turn_button_pressed():
	if game_manager.current_state == Game_Manager.GameState.PLAYER_TURN:
		game_manager.transition_state(Game_Manager.GameState.ENEMY_TURN)
		$DeckNHand.send_hand_to_pile(discard_pile)



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

func _on_show_discard_pressed():
	if discard_viewer_toggle == 0:
		game_manager.pause()
		$CanvasLayer/DeckViewer.visible = true
		$CanvasLayer/DeckViewerBackground.visible = true
		$CanvasLayer/DeckViewer.display_card_list(discard_pile.get_cards())
		discard_viewer_toggle = 1
	else:
		game_manager.unpause()
		$CanvasLayer/DeckViewer.visible = false
		$CanvasLayer/DeckViewerBackground.visible = false
		discard_viewer_toggle = 0


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




func _on_holder_timeout():
	$CanvasLayer/PlayerDamaged.visible = false
	$GameScreen/EnemyCharacter.reset_pos(position_holder)
