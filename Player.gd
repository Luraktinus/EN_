# started on 5.Nov.2018
extends KinematicBody2D

const SPEED = 2000
const AIR_SPEED = SPEED / 3
const GRAVITY = Vector2(0, 2000)
const JUMP_FORCE = 85
const JUMP_FORCE_WALL = Vector2(20000, 85)
const JUMP_REDUCTION_HOLD = 120
const JUMP_REDUCTION_RELEASE = 220
const FRICTION_AIR = 0.99
const FRICTION_FLOOR = 0.89
const FLOORSLIDE = 20
const WALL_FRICTION = 0.8

var movement_acceleration = Vector2()
var jump_acceleration = Vector2()
var velocity = Vector2()
var jumped_last_frame = false
var jump 
var walk_left
var walk_right

func _process(delta):
	
	walk_right = Input.is_action_pressed("ui_right")
	walk_left = Input.is_action_pressed("ui_left")
	jump = Input.is_action_pressed("ui_accept")
	
	
	animation(delta)
	walk(delta)
	friction(delta)
	jump(delta)
	wallslide(delta)
	walljump()
	
	velocity += GRAVITY * delta
	velocity += movement_acceleration * delta
	velocity += jump_acceleration
	velocity = move_and_slide(velocity, Vector2(0, -1))


func animation(delta):
	if walk_left and walk_right:
		walk_left = false
		walk_right = false
	if walk_left == false and walk_right == false and is_on_floor():
		$AnimationPlayer.set_current_animation("idle")
	elif not is_on_floor():
		if velocity.y < 0 :
			$AnimationPlayer.set_current_animation("jump")
		elif $RayLeft.is_colliding() or $RayRight.is_colliding():
			$AnimationPlayer.set_current_animation("wall")
		else:
			$AnimationPlayer.set_current_animation("fall")
	else:
		$AnimationPlayer.set_current_animation("walk")
	if not (walk_left or walk_right) and abs(velocity.x) > FLOORSLIDE and is_on_floor():
		$AnimationPlayer.set_current_animation("slide")
	if velocity.x < 0:
		$Sprite.scale = Vector2(-1, 1)
	elif velocity.x > 0:
		$Sprite.scale = Vector2(1, 1)

func walk(delta):
	if walk_left:
		if is_on_floor():
			movement_acceleration = Vector2(-SPEED, 0)
		else: 
			movement_acceleration = Vector2(-AIR_SPEED, 0)
	elif walk_right:
		if is_on_floor():
			movement_acceleration = Vector2(SPEED, 0)
		else:
			movement_acceleration = Vector2(AIR_SPEED, 0)
	else:
		movement_acceleration = Vector2()
		
		
	
	
func friction(delta): 
	if is_on_floor() and not (walk_left or walk_right):
		velocity.x *= FRICTION_FLOOR
	else:
		velocity.x *= FRICTION_AIR
	pass


func jump(delta):
	if is_on_floor():
		jump_acceleration = Vector2()
	if jump and is_on_floor() and not jumped_last_frame:
		jump_acceleration = Vector2(0, -JUMP_FORCE)
		jumped_last_frame = true
	elif jump and not is_on_floor() and jumped_last_frame:
		jump_acceleration += Vector2(0, JUMP_REDUCTION_HOLD) * delta
	elif not jump:
		jump_acceleration += Vector2(0, JUMP_REDUCTION_RELEASE) * delta
		jumped_last_frame = false
	
	if jump_acceleration.y > 0 or is_on_ceiling():
		jump_acceleration = Vector2()
		
		
func is_wallsliding():
	if (walk_left or walk_right) and velocity.y > 0 and ($RayLeft.is_colliding() or $RayRight.is_colliding()):
		return true
	else:
		return false

func wallslide(delta):
	if is_wallsliding():
		velocity.y *= WALL_FRICTION

func walljump():
	if is_wallsliding() and not jumped_last_frame and jump:
		if $RayLeft.is_colliding():
			movement_acceleration.x += JUMP_FORCE_WALL.x
			jump_acceleration.y -= JUMP_FORCE_WALL.y
			jumped_last_frame = true
		elif $RayRight.is_colliding():
			movement_acceleration.x -= JUMP_FORCE_WALL.x
			jump_acceleration.y -= JUMP_FORCE_WALL.y
			jumped_last_frame = true

#--- ESC exits
func _input(event):
	if event is InputEventKey and event.is_pressed():
		if event.get_scancode() == KEY_ESCAPE:
			get_tree().quit()
