extends Control




func _input(event):
	if event is InputEventKey and event.is_pressed():
		if event.get_scancode() == KEY_ESCAPE:
			get_tree().quit()


func _on_PlayButton_pressed():
	get_tree().change_scene("res://Menu/LevelMenu.tscn")


func _on_HelpButton_pressed():
	get_tree().change_scene("res://Menu/Help.tscn")


func _on_ExitButton_pressed():
	get_tree().quit()
