extends Area2D

onready var root = str(get_tree().get_current_scene().name)
onready var player = get_tree().get_nodes_in_group("Player")[0]

func _ready():
	print(player)

func _on_HitBox_body_entered(body):
	player.death()

