extends KinematicBody2D

onready var player = $"../Player"

const GRAVITY = Vector2(0, 1000)
const SPEED = 200
const JUMP_STRENGTH = -30000
var movement = Vector2()
var velocity = Vector2()


func _process(delta):
	if player.position.x < position.x:
		movement.x = -SPEED
	elif player.position.x > position.x:
		movement.x = SPEED
	
	if abs(player.position.x - position.x) < 200 and is_on_floor():
		movement.y = JUMP_STRENGTH
	else:
		movement.y = 0
	
	velocity += movement * delta
	velocity += GRAVITY * delta
	velocity = move_and_slide(velocity, Vector2(0, -1))