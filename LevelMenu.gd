extends Control

var savegame = File.new() #file
var save_path = "user://level.save" #place of the file
var save_data = {"level": 1} #variable to store data

	
func _ready():
	if not savegame.file_exists(save_path):
		create_save()
	print("Read savefile: "+str(read_savegame()))
	for i in range(1, int(read_savegame())+1):
		get_node("ScrollContainer/GridContainer/Button"+str(i)).disabled = false
	

func create_save():
	savegame.open(save_path, File.WRITE)
	savegame.store_var(save_data)
	savegame.close()
	print("create files")
	
func read_savegame():
	savegame.open(save_path, File.READ) #open the file
	save_data = savegame.get_var() #get the value
	savegame.close() #close the file
	return save_data["level"] #return the value

func _on_Button1_pressed():
	get_tree().change_scene("res://Levels/1.tscn")
func _on_Button2_pressed():
	get_tree().change_scene("res://Levels/2.tscn")
func _on_Button3_pressed():
	get_tree().change_scene("res://Levels/3.tscn")
func _on_Button4_pressed():
	get_tree().change_scene("res://Levels/4.tscn")
func _on_Button5_pressed():
	get_tree().change_scene("res://Levels/5.tscn")
func _on_Button6_pressed():
	get_tree().change_scene("res://Levels/6.tscn")
func _on_Button7_pressed():
	get_tree().change_scene("res://Levels/7.tscn")
func _on_Button8_pressed():
	get_tree().change_scene("res://Levels/8.tscn")
func _on_Button9_pressed():
	get_tree().change_scene("res://Levels/9.tscn")
func _on_Button10_pressed():
	get_tree().change_scene("res://Levels/10.tscn")
func _on_Button11_pressed():
	get_tree().change_scene("res://Levels/11.tscn")
func _on_Button12_pressed():
	get_tree().change_scene("res://Levels/12.tscn")
func _on_Button13_pressed():
	get_tree().change_scene("res://Levels/13.tscn")
func _on_Button14_pressed():
	get_tree().change_scene("res://Levels/14.tscn")
func _on_Button15_pressed():
	get_tree().change_scene("res://Levels/15.tscn")
func _on_Button16_pressed():
	get_tree().change_scene("res://Levels/16.tscn")
func _on_Button17_pressed():
	get_tree().change_scene("res://Levels/17.tscn")
func _on_Button18_pressed():
	get_tree().change_scene("res://Levels/18.tscn")
func _on_Button19_pressed():
	get_tree().change_scene("res://Levels/19.tscn")
func _on_Button20_pressed():
	get_tree().change_scene("res://Levels/20.tscn")
func _on_Button21_pressed():
	get_tree().change_scene("res://Levels/21.tscn")
func _on_Button22_pressed():
	get_tree().change_scene("res://Levels/22.tscn")
func _on_Button23_pressed():
	get_tree().change_scene("res://Levels/23.tscn")
func _on_Button24_pressed():
	get_tree().change_scene("res://Levels/24.tscn")
func _on_Button25_pressed():
	get_tree().change_scene("res://Levels/25.tscn")
func _on_Button26_pressed():
	pass # Replace with function body.
