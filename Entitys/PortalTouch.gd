extends Area2D




func _on_PortalTouch_body_entered(body):
	body.set_collision_mask_bit(7, true)
	body.set_collision_mask_bit(0, false)
	body.set_collision_mask_bit(4, false)
	pass


func _on_PortalTouch_body_exited(body):
	body.set_collision_mask_bit(7, false)
	body.set_collision_mask_bit(0, true)
	body.set_collision_mask_bit(4, true)
	pass
