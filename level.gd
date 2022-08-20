extends Node2D



const distance = 25
#var pp = $pointCintainer.get_children()
func _process(delta):
	## Animate the Arm
	$pointContainer/point50.position = get_global_mouse_position()
	for i in range(100):
		var pp = $pointContainer.get_children()
		var counter = len(pp) - 1
		
		## iterate from the end point back to start
		while counter >= 0:
			if pp[counter].name == 'point50':
				pass
			else:
				if counter == 0:
					pass
				else:
					var length = sqrt(pow((pp[counter].position.x - pp[counter + 1].position.x),2) + pow((pp[counter].position.y - pp[counter + 1].position.y),2))
					var angle = get_angle_to((pp[counter].position - pp[counter + 1].position).normalized())
					if length != distance:
						pp[counter].position += Vector2((distance - length)*cos(angle),(distance - length)*sin(angle))
			counter -= 1
		
		## iterate from start to end point
		for pointi in range(len(pp)):
			if pp[pointi].name == 'point':
				pass
				
			else:
				var length = sqrt(pow((pp[pointi].position.x - pp[pointi-1].position.x),2) + pow((pp[pointi].position.y - pp[pointi-1].position.y),2))
				var angle = get_angle_to((pp[pointi].position - pp[pointi-1].position).normalized())
				if length != distance:
					pp[pointi].position += Vector2((distance - length)*cos(angle),(distance - length)*sin(angle))
	
	update()	
	## Draw the Arm
func _draw():
	var pp = $pointContainer.get_children()
	for point in range(len(pp)):
		if pp[point].name == 'point50':
			pass
		else:
			draw_line(pp[point].global_position,pp[point+1].global_position,Color(0.862745, 0.0784314, 0.235294, 1),20)
		draw_circle(pp[point].global_position,10,Color(0.862745, 0.0784314, 0.235294, 1))
		
