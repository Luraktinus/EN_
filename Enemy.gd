extends KinematicBody2D

onready var player = $"../../Player"
onready var navmesh = $"../../Navigation2D"

var path = []

const GRAVITY = Vector2(0, 1500)
const SPEED = 400
const JUMP_STRENGTH = 30000

var movement = Vector2()
var velocity = Vector2()



func _process(delta):
	path = navmesh.get_simple_path(position, player.position, true)
	path.remove(0)
	if path.size() > 0:
		goto(path[0])
	
	velocity += movement * delta
	velocity += GRAVITY * delta
	if velocity.y < -JUMP_STRENGTH * delta:
		velocity.y = -JUMP_STRENGTH * delta
	velocity.x *= 0.98
	velocity = move_and_slide(velocity, Vector2(0, -1))


func goto(goal):
	if goal.x > position.x:
		movement.x = SPEED
	elif goal.x < position.x:
		movement.x = -SPEED
	else:
		movement.x = 0
	
	if goal.y + 30 < position.y and is_on_floor() and abs(goal.x - position.x) < 100 and movement.y <= 0:
		movement.y = -JUMP_STRENGTH
	else:
		movement.y = 0
