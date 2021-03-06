extends KinematicBody2D

onready var root = str(get_tree().get_current_scene().name)
onready var player = get_tree().get_nodes_in_group("Player")[0]
onready var navmesh = get_tree().get_nodes_in_group("NavMesh")[0]

var path = []
var path2 = []

const GRAVITY = Vector2(0, 1500)
const SPEED = 600
const JUMP_STRENGTH = 40000

var movement = Vector2()
var velocity = Vector2()

const CD_CALC_PATH = 300
var cd_calc_path = CD_CALC_PATH + randi()%60


func _ready():
	path = calc_path(player.position)
	if path.size():
		path.remove(0)

func _physics_process(delta):
	if cd_calc_path < 0:
		path = calc_path(player.position)
		if path.size():
			path.remove(0)
		cd_calc_path = CD_CALC_PATH + randi()%60
	else:
		cd_calc_path -= 1
	if path.size():
		if position.distance_to(path[0]) < 30:
			if path.size():
				path.remove(0)
	if path.size() == 1:
		path2 = calc_path(player.position)
	elif path.size():
		path2 = calc_path(path[0])
	if path2.size():
		goto(path2[1])
	
	
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
		if ((is_on_wall() or abs(goal.x - position.x) < 46 and goal.y < position.y -14) or velocity.length() < 5):
			movement.y = -JUMP_STRENGTH
	else:
		movement.y = 0


func calc_path(target_position):
	if is_instance_valid(player):
		return navmesh.get_simple_path(position, target_position, true)


