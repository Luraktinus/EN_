extends KinematicBody2D

onready var player = $"../../Player"
onready var navmesh = $"../../Navigation2D"

var path = []

const GRAVITY = Vector2(0, 1500)
const SPEED = 600
const JUMP_STRENGTH = 40000

var movement = Vector2()
var velocity = Vector2()

const CD_CALC_PATH = 60
var cd_calc_path = CD_CALC_PATH


func _ready():
	calc_path()


func _process(delta):
	if cd_calc_path < 0:
		calc_path()
		cd_calc_path = CD_CALC_PATH + randi()%100
	else:
		cd_calc_path -= 1
	if position.distance_to(path[0]) < 10:
		calc_path()
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
	
	if is_on_floor() and movement.y <= 10:
		if (is_on_wall() or abs(goal.x - position.x) < 24) and goal.y < position.y:
			movement.y = -JUMP_STRENGTH
	else:
		movement.y = 0


func calc_path():
	path = navmesh.get_simple_path(position, player.position + Vector2(0, 30), true)
	path.remove(0)


