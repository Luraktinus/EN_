extends KinematicBody2D

onready var player = $"../../Player"
onready var navmesh = $"../../Navigation2D"

var path = []

const GRAVITY = Vector2(0, 1500)
const SPEED = 600
const JUMP_STRENGTH = 40000

var movement = Vector2()
var velocity = Vector2()



func _physics_process(delta):
	calc_path()
	if path.size() > 1:
		goto(path[1])
	
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
	
	if is_on_floor() and movement.y <= 10:
		if (is_on_wall() or abs(goal.x - position.x) < 32 or velocity.length() < 0) and goal.y < position.y:
			movement.y = -JUMP_STRENGTH
	else:
		movement.y = 0


func calc_path():
	if is_instance_valid(player):
		path = navmesh.get_simple_path(position, player.position + Vector2(0, 30), true)


