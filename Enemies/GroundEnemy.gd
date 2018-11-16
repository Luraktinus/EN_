extends KinematicBody2D


const GRAVITY = Vector2(0, 1500)
const SPEED = 2000
const JUMP_STRENGTH = 40000
const FRICTION = 0.99

var movement = Vector2()
var velocity = Vector2()

func _physics_process(delta):
	if $RayCastLeft.is_colliding() and is_on_floor():
		movement.x = -SPEED
	elif $RayCastRight.is_colliding() and is_on_floor():
		movement.x = SPEED
	else:
		movement.x = 0
	velocity += movement * delta
	velocity += GRAVITY * delta
	velocity.x *= FRICTION
	velocity = move_and_slide(velocity, Vector2(0, -1))
