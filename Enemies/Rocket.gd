extends KinematicBody2D

onready var player = $"../../Player"

signal exploded

const SPEED = Vector2(1400, 0)
const ROTATION_SPEED = 0.04

var rotation_movement = 0
var movement = Vector2()
var velocity = Vector2()

const CD_CALC_PATH = 300
var cd_calc_path = CD_CALC_PATH + randi() % 60

func _ready():
	rotation = position.angle_to(player.position)

func _physics_process(delta):
	goto(player.position)
	
	rotation += rotation_movement
	movement = SPEED.rotated(rotation)
	velocity += movement * delta
	velocity *= 0.95
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
		rotation_movement = ROTATION_SPEED
	elif angle_dif > 0:
		rotation_movement = -ROTATION_SPEED


func wall_collision():
	queue_free()
	emit_signal("exploded")