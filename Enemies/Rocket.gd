extends KinematicBody2D

onready var root = str(get_tree().get_current_scene().name)
onready var player = get_node("/root/"+root+"/Player")

signal exploded

const SPEED = Vector2(1800, 0)
const ROTATION_SPEED = 0.04

var rotation_movement = 0
var movement = Vector2()
var velocity = Vector2()


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
	$AudioExplode.play()
	visible = false
	$DeathTimer.start()
	emit_signal("exploded")

func _on_DeathTimer_timeout():
	queue_free()
