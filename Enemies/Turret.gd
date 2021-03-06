extends Node2D
 
var rocket_res = load("res://Enemies/Rocket.tscn")

onready var player = get_tree().get_nodes_in_group("Player")[0]

onready var ray = $Ray
export var max_rockets = 1
var rocket_count = 0
export var cooldown = 120
var cd = cooldown

func _ready():
	ray.cast_to = -(position - player.position)

func _physics_process(delta):
	cd -= 1
	if cd == 1:
		ray.cast_to = -(position - player.position)
	if cd <= 0 and max_rockets > rocket_count:
		if player_visible():
			shoot()
			cd = cooldown
		ray.cast_to = -(position - player.position)


func player_visible():
	if ray.is_colliding():
		return false
	return true


func shoot():
	var rocket = rocket_res.instance()
	rocket.position = position
	rocket.connect("exploded", self, "rocket_exploded")
	get_parent().add_child(rocket)
	rocket_count += 1
	$AudioTracked.play()


func rocket_exploded():
	rocket_count -= 1
