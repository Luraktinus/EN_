extends Area2D

onready var player = $"../../../Player"


func _on_HitBox_body_entered(body):
	player.call("death")

