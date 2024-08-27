extends Node2D

func _ready():
	$UI/MenuOverlay.in_battle = false

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
	get_tree().change_scene_to_file("res://main.tscn")


func _on_event_2_pressed():
	Recorder.advance()


func _on_event_3_pressed():
	Recorder.advance()
	get_tree().change_scene_to_file("res://main.tscn")


func _on_menu_toggle_pressed():
	$UI/MenuOverlay.visible = !$UI/MenuOverlay.visible
	



func _on_menu_overlay_quit_pressed():
	get_tree().quit()


func _on_menu_overlay_return_2_menu_pressed():
	get_tree().change_scene_to_file("res://UI Scenes/main_menu.tscn")
