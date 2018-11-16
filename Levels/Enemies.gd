extends Node2D


func _process(delta):
	update()


func _draw():
	for child in get_children():
		if child.path.size() > 1:
			for i in range(child.path.size()-1):
				draw_line(child.path[i], child.path[i+1], Color(1,1,1), 3.0)