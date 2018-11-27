extends Area2D

onready var root = str(get_tree().get_current_scene().name)
onready var goal = get_node("/root/"+root+"/Goal")

var on = false

func _ready():
	goal.switch_login()
	print("Switch count: "+str(goal.switch_count))

func seton():
	if not on:
		$SpriteON.visible = true
		$SpriteOFF.visible = false
		on = true
		goal.switch_activated()
		print("Switch count: " + str(goal.switch_count))
		$AudioOn.play()


func _on_Switch_body_entered(body):
	seton()
