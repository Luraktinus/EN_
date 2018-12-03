extends Button

var level = 0

func _ready():
	$Label.text = str(level)


func _on_Button1_pressed():
	get_tree().get_nodes_in_group("levelpreview")[0].change_scene("res://Levels/" + str(level) + ".tscn")
	get_tree().paused = false

func set_font(font):
	print(font)
	$Label.set("custom_fonts/font", load(font))
