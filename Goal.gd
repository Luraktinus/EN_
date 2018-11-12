extends Area2D

onready var scene = "res://Levels/" + str(int(get_tree().get_current_scene().name) + 1) + ".tscn"


func _on_Goal_body_entered(body):
	get_tree().change_scene(scene)
