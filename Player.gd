# started on 5.Nov.2018

extends KinematicBody2D

const SPEED = 2000
const AIR_SPEED = SPEED / 3
const GRAVITY = 1500
const JUMP_FORCE = 4000
const JUMP_FORCE_WALL = 20000
const JUMP_REDUCTION_HOLD = 100
const JUMP_REDUCTION_RELEASE = 200
const FRICTION_AIR = 0.99
const FRICTION_FLOOR = 0.89
const FLOORSLIDE = 20
const WALL_FRICTION = 0.8

onready var scene = "res://Levels/" + get_tree().get_current_scene().name + ".tscn"



var alive = true
var movement_acceleration = Vector2()
var jump_acceleration = Vector2()
var velocity = Vector2()
var jumped_last_frame = false
var jump 
var walk_left
var walk_right



func _physics_process(delta):
	walk_right = Input.is_action_pressed("ui_right") and alive
	walk_left = Input.is_action_pressed("ui_left") and alive
	jump = Input.is_action_pressed("ui_up") and alive
	
	animation()
	walk()
	friction()
	jump()
	wallslide()
	walljump()
	var lenvelocity = velocity.length()
	velocity.y += GRAVITY * delta
	velocity += movement_acceleration * delta
	velocity += jump_acceleration * delta
	
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	if lenvelocity/(delta+0.0000000001)/60 > velocity.length()/(delta+0.0000000001)/60 + 1500: # 12 blocks ded
		death()


func animation():
	if walk_left and walk_right:
		walk_left = false
		walk_right = false
	if walk_left == false and walk_right == false and is_on_floor():
		$AnimationPlayer.set_current_animation("idle")
	elif not is_on_floor():
		if velocity.y < 0 :
			$AnimationPlayer.set_current_animation("jump")
		elif $RayLeft.is_colliding() and walk_left:
			$Sprite.scale = Vector2(-1, 1)
			$AnimationPlayer.set_current_animation("wall")
		elif $RayRight.is_colliding() and walk_right:
			$Sprite.scale = Vector2(1, 1)
			$AnimationPlayer.set_current_animation("wall")
			pass
		else:
			$AnimationPlayer.set_current_animation("fall")
	else:
		$AnimationPlayer.set_current_animation("walk")
	if not (walk_left or walk_right) and abs(velocity.x) > FLOORSLIDE and is_on_floor():
		$AnimationPlayer.set_current_animation("slide")
	if velocity.x < -1 and walk_left:
		$Sprite.scale = Vector2(-1, 1)
	elif velocity.x > 1 and walk_right:
		$Sprite.scale = Vector2(1, 1)


func walk():
	if walk_left:
		if is_on_floor():
			movement_acceleration.x = -SPEED
		else: 
			movement_acceleration.x = -AIR_SPEED
	elif walk_right:
		if is_on_floor():
			movement_acceleration.x = SPEED
		else:
			movement_acceleration.x = AIR_SPEED
	else:
		movement_acceleration = Vector2()


func friction(): 
	if is_on_floor() and not (walk_left or walk_right):
		velocity.x *= FRICTION_FLOOR
	else:
		velocity.x *= FRICTION_AIR


func jump():
	if jump:
		if is_on_floor() and not jumped_last_frame:
			jump_acceleration.y -= JUMP_FORCE
			jumped_last_frame = true
		if not is_on_floor() and jumped_last_frame:
			jump_acceleration.y += JUMP_REDUCTION_HOLD
			jumped_last_frame = true
	if not jump:
		if not is_on_floor() and jumped_last_frame:
			jump_acceleration.y += JUMP_REDUCTION_RELEASE
		if is_on_floor():
			jump_acceleration.y = 0
			jumped_last_frame = false
	if jump_acceleration.y > 0 or is_on_ceiling():
		jump_acceleration.y = 0


func is_wallsliding():
	if (walk_left or walk_right) and ($RayLeft.is_colliding() or $RayRight.is_colliding()) and velocity.y > 0:
		return true
	else:
		return false


func wallslide():
	if is_wallsliding():
		velocity.y *= WALL_FRICTION


func walljump():
	if is_wallsliding() and jump and not jumped_last_frame:
		if $RayLeft.is_colliding():
			velocity.y = 0
			movement_acceleration.x += JUMP_FORCE_WALL
			jump_acceleration.y -= JUMP_FORCE
			jumped_last_frame = true
		elif $RayRight.is_colliding():
			velocity.y = 0
			movement_acceleration.x -= JUMP_FORCE_WALL
			jump_acceleration.y -= JUMP_FORCE
			jumped_last_frame = true
	if is_wallsliding() and not jump:
		jumped_last_frame = false


#--- ESC exits
func _input(event):
	if event is InputEventKey and event.is_pressed():
		if event.get_scancode() == KEY_ESCAPE:
			get_tree().change_scene("res://Menu.tscn")


func _on_DeathTimer_timeout():
	get_tree().change_scene(scene)
	
func death():
	print("Death")
	if alive:
		$DeathTimer.start()
	alive = false
	$DeathSign.visible = true
	$Sprite.visible = false
