extends Area2D

onready var scene = "res://Levels/" + str(int(get_tree().get_current_scene().name) + 1) + ".tscn"
onready var player = $"../Player"

var savegame = File.new() #file
var save_path = "user://level.save" #place of the file
var save_data = {"level": scene} #variable to store data
var next_level = ""

var switch_count = 0




func _on_Goal_body_entered(body):
	if player.alive and switch_count <= 0:
		next_level = str(int(get_tree().get_current_scene().name) + 1)
		if int(read_savegame()) < int(next_level):
			print("Save level: " + next_level)
			save(next_level)
		get_tree().change_scene(scene)

func read_savegame():
	print("Read savefile")
	savegame.open(save_path, File.READ) #open the file
	save_data = savegame.get_var() #get the value
	savegame.close() #close the file
	return save_data["level"] #return the value

func save(scene):    
	save_data["level"] = scene #data to save
	savegame.open(save_path, File.WRITE) #open file to write
	savegame.store_var(save_data) #store the data
	savegame.close() # close the file
