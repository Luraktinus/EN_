extends KinematicBody2D

onready var player = $"../../Player"
onready var navmesh = $"../../Navigation2D"

var path = []

const GRAVITY = Vector2(0, 600)
const SPEED = 400
const JUMP_STRENGTH = 30000

var movement = Vector2()
var velocity = Vector2()

var s = 0


func _process(delta):
	if s > 3:
		path = navmesh.get_simple_path(position, player.position, true)
		path.remove(0)
		if path.size() > 0:
			goto(path[0])
	else:
		path = navmesh.get_simple_path(position, player.position, false)
		path.remove(0)
		if path.size() > 1:
			goto(path[1])
	if s == 4:
		s = 0
	s += 1
	
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
	
	if goal.y + 30 < position.y and $RayCast2D.is_colliding() and abs(goal.x - position.x) < 100 and movement.y <= 0:
		movement.y = -JUMP_STRENGTH
	else:
		movement.y = 0
