extends Area2D

onready var root = str(get_tree().get_current_scene().name)
onready var player = get_node("/root/"+root+"/Player")

func _ready():
	print(player)

func _on_HitBox_body_entered(body):
	player.death()

