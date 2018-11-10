extends Node2D

func _process(delta):
	if $Player/RayLeft.get_collider() == $Goal or $Player/RayRight.get_collider() == $Goal:
		get_tree().change_scene("res://Levels/Intro.tscn")
	pass
