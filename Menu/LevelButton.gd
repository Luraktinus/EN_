extends Button

var level = 0

func _ready():
	$Label.text = str(level)


func _on_Button1_pressed():
	get_tree().change_scene("res://Levels/" + str(level) + ".tscn")


func set_font(font):
	print(font)
	$Label.set("custom_fonts/font", load(font))
