extends Button

func _input(event):
	if event is InputEventKey and event.is_pressed():
		if event.get_scancode() == KEY_ESCAPE:
			get_tree().quit()


func _on_ButtonExit_pressed():
	get_tree().quit()
