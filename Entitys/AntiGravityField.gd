extends Sprite

var GRAVITY = 1500

func _on_Area2D_body_entered(body):
	body.GRAVITY = 0


func _on_Area2D_body_exited(body):
	body.GRAVITY = GRAVITY
