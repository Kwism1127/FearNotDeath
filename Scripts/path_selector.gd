extends Node2D

func _ready():
	$UI/MenuOverlay.in_battle = false
	$EventPage/Combat1.visible = false
	$EventPage/Combat2.visible = false
	$EventPage/Event1.visible = false

func _process(_delta):
	if Recorder.get_progress() == 1:
		$Event1.disabled = false
		$Event2.disabled = true
		$Event3.disabled = true
	
	if Recorder.get_progress() == 2:
		$Event1.disabled = true
		$Event2.disabled = false
		$Event3.disabled = true
	
	if Recorder.get_progress() == 3:
		$Event1.disabled = true
		$Event2.disabled = true
		$Event3.disabled = false
	
	if Recorder.get_progress() > 3:
		$Event1.disabled = true
		$Event2.disabled = true
		$Event3.disabled = true
		$Defocus.visible = true

func _on_event_1_pressed():
	Recorder.advance()
	$EventPage/Combat1.visible = true

func _on_to_battle_pressed():
	get_tree().change_scene_to_file("res://main.tscn")


func _on_event_2_pressed():
	Recorder.advance()
	$EventPage/Event1.visible = true


func _on_event_3_pressed():
	Recorder.advance()
	$EventPage/Combat2.visible = true


func _on_menu_toggle_pressed():
	$UI/MenuOverlay.visible = !$UI/MenuOverlay.visible
	



func _on_menu_overlay_quit_pressed():
	get_tree().quit()


func _on_menu_overlay_return_2_menu_pressed():
	get_tree().change_scene_to_file("res://UI Scenes/main_menu.tscn")




func _on_help_pressed():
	PlayerInv.adjust_bullets(2)
	$EventPage/Event1/ResultHelp.visible = true
	$EventPage/Event1/Situation.visible = false
	$EventPage/Event1/Continue.visible = true
	$EventPage/Event1/Help.visible = false
	$EventPage/Event1/Loot.visible = false
	
func _on_loot_pressed():
	PlayerInv.adjust_bolts(6)
	$EventPage/Event1/ResultGrab.visible = true
	$EventPage/Event1/Situation.visible = false
	$EventPage/Event1/Continue.visible = true
	$EventPage/Event1/Help.visible = false
	$EventPage/Event1/Loot.visible = false

func _on_continue_pressed():
	$EventPage/Event1.visible = false
