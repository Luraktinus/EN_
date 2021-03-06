extends Control

var file = File.new() #file
var save_path = "user://level.save" #place of the file
var save_data = {"level": 1} #variable to store data
var button_res = load("res://Menu/LevelButton.tscn")
var lvl_reached = 1
var selected_lvl = 1



func _ready():
	get_tree().paused = true
	if not file.file_exists(save_path):
		create_save()
	else:
		lvl_reached = int(read_savegame())
	var n = 1
	while file.file_exists("res://Levels/" + str(n) + ".tscn"):
		n += 1
	n -= 1
	for i in range(1,n+1):
		var button = button_res.instance()
		button.level = i
		if i > lvl_reached:
			button.disabled = true
			button.set_font("res://Menu/MenuFont50.tres")
		else:
			button.set_font("res://Menu/MenuFont100.tres")
		button.connect("selected", self, "set_selected")
		get_tree().get_nodes_in_group("buttoncontainer")[0].add_child(button)


func set_selected(level):
	selected_lvl = level


func create_save():
	file.open(save_path, File.WRITE)
	file.store_var(save_data)
	file.close()
	print("create files")


func read_savegame():
	file.open(save_path, File.READ) #open the file
	save_data = file.get_var() #get the value
	file.close() #close the file
	return save_data["level"] #return the value


func _input(event):
	if event is InputEventKey and event.is_pressed():
		if event.get_scancode() == KEY_ESCAPE:
			get_tree().change_scene("res://Menu/Menu.tscn")


func _on_PlayButton_pressed():
	if selected_lvl <= lvl_reached:
		get_tree().paused = false
		get_tree().change_scene("res://Levels/" + str(selected_lvl) + ".tscn")
