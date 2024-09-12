#extends Node2D
#
#@onready var text_index: int = 0
#@onready var background_index: int = 0
#
#@onready var text_control_array: Array[Array] = [[$Background0/Paragraph0, $Background0/Paragraph1], [$Background1/Paragraph0, $Background1/Paragraph1], [$Background2/Paragraph0, $Background2/Paragraph1], [$Background3/Paragraph0, $Background3/Paragraph1]]
#@onready var background_contorl_array: Array = [$Background0, $Background1, $Background2, $Background3]
#
#
#
#
#func _input(event):
	#if event.is_action_pressed("left_mouse_click"):
		#if text_index == 0:
			#text_index = 1
			#text_control_array[background_index][text_index].visible = true
		#elif text_index == 1 && background_index < 3:
			#text_index = 0
			#background_index += 1
			#background_contorl_array[background_index].visible = true
			#text_control_array[background_index][text_index].visible = true
		#else:
			#get_tree().change_scene_to_file("res://path_selector.tscn")
