extends Tween

onready var elevator = $".."
onready var door = $"../Door"

var rotation = 90
onready var esp = elevator.position
var pc = Vector2(0,-1500)

func _ready():
	repeat = true
	set_active(true)
	interpolate_property(door, "rotation", 0, 0.5*PI, 1, Tween.TRANS_LINEAR, Tween.EASE_IN, 1)
	interpolate_property(door, "rotation", 0.5*PI, 0, 1, Tween.TRANS_LINEAR, Tween.EASE_IN, 3)
	interpolate_property(elevator, "position", esp, esp + pc, 5, Tween.TRANS_LINEAR, Tween.EASE_IN, 5)
	
	interpolate_property(door, "rotation", 0, 0.5*PI, 1, Tween.TRANS_LINEAR, Tween.EASE_IN, 11)
	interpolate_property(door, "rotation", 0.5*PI, 0, 1, Tween.TRANS_LINEAR, Tween.EASE_IN, 13)
	interpolate_property(elevator, "position", esp + pc, esp, 5, Tween.TRANS_LINEAR, Tween.EASE_IN, 15)
	
	start()
	
	pass
	
	
	