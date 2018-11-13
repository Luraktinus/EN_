extends Area2D

onready var scene = "res://Levels/" + get_tree().get_current_scene().name + ".tscn"


func _on_Mine_body_entered(body):
	get_tree().change_scene(scene)
