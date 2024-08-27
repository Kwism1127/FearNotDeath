extends ColorRect

signal restart_pressed
signal quit_pressed
signal return_2_menu_pressed

@onready var in_battle: bool = true

func _process(_delta):
	if !in_battle:
		$Restart.visible = false
		$PAUSED.visible = false
	else:
		$Restart.visible = true
		$PAUSED.visible = true

func _on_restart_pressed():
	restart_pressed.emit()

func _on_return_2_menu_pressed():
	return_2_menu_pressed.emit()

func _on_quit_pressed():
	quit_pressed.emit()
