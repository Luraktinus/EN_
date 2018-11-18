extends KinematicBody2D

onready var player = $"../../Player"
onready var navmesh = $"../../Navigation2D"

var path = []
var path2 = []

const SPEED = Vector2(400, 0)
const ROTATION_SPEED = 0.001

var rotation_movement = 0
var rotation_velocity = 0
var movement = Vector2()
var velocity = Vector2()

const CD_CALC_PATH = 300
var cd_calc_path = CD_CALC_PATH + randi() % 60


func _ready():
	path = calc_path(player.position)
	if path.size():
		path.remove(0)

func _physics_process(delta):
	if cd_calc_path < 0:
		path = calc_path(player.position)
		if path.size():
			path.remove(0)
		cd_calc_path = CD_CALC_PATH + randi() % 60
	else:
		cd_calc_path -= 1
	if path.size():
		if position.distance_to(path[0]) < 50:
			if path.size():
				path.remove(0)
	if path.size() == 1:
		path2 = calc_path(player.position)
	elif path.size():
		path2 = calc_path(path[0])
	if path2.size():
		goto(path2[1])
	
	rotation_velocity += rotation_movement
	rotation += rotation_velocity
	rotation_velocity *= 0.2
	movement = SPEED.rotated(rotation)
	velocity += movement * delta
	velocity *= 0.98
	velocity = move_and_slide(velocity)


func goto(goal):
	var vec = goal - position
	var target_dir = vec.angle()
	var facingMinusTarget = rotation - target_dir
	var angle_dif = facingMinusTarget
	if abs(facingMinusTarget) > PI:
		angle_dif = (2 * PI - rotation) + target_dir
		if rotation > target_dir:
			angle_dif *= -1
	if angle_dif < 0:
		rotation_movement += ROTATION_SPEED
	elif angle_dif > 0:
		rotation_movement -= ROTATION_SPEED


func calc_path(target_position):
	if is_instance_valid(player):
		return navmesh.get_simple_path(position, target_position, true)


