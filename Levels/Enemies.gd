extends Node2D


func _process(delta):
	update()


#func _draw():
#	for child in get_children():
#		if child.get("path"):
#			if child.path.size() > 1:
#					for i in range(child.path.size()-1):
#						draw_line(child.path[i], child.path[i+1], Color(1,1,1), 3.0)
#		if child.get("path2"):
#			if child.path2.size() > 1:
#					for i in range(child.path2.size()-1):
#						draw_line(child.path2[i], child.path2[i+1], Color(0.2,1,0.2), 3.0)
#
#
