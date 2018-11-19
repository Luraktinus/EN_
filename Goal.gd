extends Area2D

onready var scene = "res://Levels/" + str(int(get_tree().get_current_scene().name) + 1) + ".tscn"
onready var player = $"../Player"

var open = true


func _on_Goal_body_entered(body):
	if player.alive and open:
		get_tree().change_scene(scene)
