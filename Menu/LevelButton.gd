extends Button

var level = 0

func _ready():
	text = str(level)

func _on_Button1_pressed():
	get_tree().change_scene("res://Levels/" + str(level) + ".tscn")
