extends Area2D

onready var goal = $"../../Goal"
var on = false


func _process(delta):
	if on == false:
		goal.open = false

func seton():
	$SpriteON.visible = true
	$SpriteOFF.visible = false
	on = true
	goal.open = true
	
func setoff():
	$SpriteON.visible = false
	$SpriteOFF.visible = true

func _on_Switch_body_entered(body):
	seton()
