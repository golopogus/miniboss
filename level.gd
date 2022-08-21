extends Node2D

var zoomLoc = Vector2(-1000,-1000)
var zoomOnEnemy = false
var distance = 25
var zoom = false
var mouseMove = true
var burn = false
var ENEMY = preload("res://enemy.tscn")
var ENEMY2 = preload("res://enemy2.tscn")
var ENEMY3 = preload("res://enemy3.tscn")

var enemies = [1,2,3]
var ASH = preload("res://ash.tscn")

func _ready():
	Globals.play_calm(0)
	$spawner.start()
	$first.start()
	Globals.get_node('menu').stop()
	
func _process(delta):

## Burning

	if Input.is_action_just_pressed("burn"):
		$Sprite.hide()
		$Sprite2.show()
		$steam.emitting = true
		burn = true
		if $burn.playing == false:
			$burn.play()
		
		if zoom == true:
			var anim: Animation = $AnimationPlayer.get_animation('zoomOut')
			var key_id: int = anim.track_find_key(0,0)
			if zoomOnEnemy == true:
				anim.track_set_key_value(0, key_id, zoomLoc)
			else:
				anim.track_set_key_value(0, key_id, get_global_mouse_position())
			$AnimationPlayer.play("zoomOut")
			zoom = false
			zoomOnEnemy = false
#			for child in get_node("enemyContainer").get_children():
#				if child.position == zoomLoc:
#					child.reset_pos()
		#$enemy.change_state()
	elif Input.is_action_just_released("burn"):
		$Sprite.show()
		$Sprite2.hide()
		$steam.emitting = false
		burn = false
		$burn.stop()
		
		
	if $AnimationPlayer.is_playing():
		mouseMove = false
	else:
		mouseMove = true
	if mouseMove == true:
		$Sprite.position = get_global_mouse_position()
		$Sprite2.position = get_global_mouse_position()
		if burn == true:
			$steam.position = get_global_mouse_position()
			$pointContainer/point60.position = $Sprite.position - Vector2(85,55)
		else:
			$pointContainer/point60.position = $Sprite.position - Vector2(50,-32)
		for i in range(50):
			var pp = $pointContainer.get_children()
			var counter = len(pp) - 1
			
			## iterate from the end point back to start
			while counter >= 0:
				if pp[counter].name == 'point60':
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
		if zoom == false and Globals.get_children()[0].playing == false:
			Globals.stop_boss()
			Globals.play_calm(Globals.calm_position)
			
			if Globals.get_children()[1].playing == true:
				Globals.stop_corn()
			elif Globals.get_children()[2].playing == true:
				Globals.stop_fish()
			elif Globals.get_children()[3].playing == true:
				Globals.stop_bear()
			if (Globals.corn_position != 0 or Globals.fish_position != 0 or Globals.bear_position != 0) and Globals.get_children()[5].playing == false:
				Globals.play_squeak()
			
		elif zoom == true:
			Globals.stop_calm()
			Globals.stop_squeak()
			if zoomLoc != Vector2(-1000,-1000) and Globals.voice_playing == false:
				find_enemy(zoomLoc)
			if Globals.get_children()[4].playing == false and zoomOnEnemy == true:
				Globals.play_boss()
				
	if Input.is_action_just_pressed("zoom"):
		$out.play()
	## Draw the Arm
func _draw():
	var pp = $pointContainer.get_children()
	for point in range(len(pp)):
		if pp[point].name == 'point60':
			pass
		else:
			draw_line(pp[point].global_position,pp[point+1].global_position,Color(0.862745, 0.0784314, 0.235294, 1),20)
		draw_circle(pp[point].global_position,10,Color(0.862745, 0.0784314, 0.235294, 1))
		

func _unhandled_input(event):
		if Input.is_action_just_pressed("zoom"):
			#var posDiff = sqrt(pow(get_global_mouse_position().x - MovePos.x,2) + pow(get_global_mouse_position.y - MovePos.y,2))
			
			if zoomLoc != Vector2(-1000,-1000):
				zoomOnEnemy = true
				
			print(zoom)
			if zoom == false:
				#Globals.stop_calm()
				var anim: Animation = $AnimationPlayer.get_animation('zoom')
				var key_id: int = anim.track_find_key(1,1)
				if zoomOnEnemy == true:
					anim.track_set_key_value(1, key_id, zoomLoc)
				else:
					anim.track_set_key_value(1, key_id, get_global_mouse_position())
				$AnimationPlayer.play("zoom")
				#$in.play()
				#Globals.stop_calm()
				
				
				
			elif zoom == true:
				#Globals.play_calm(Globals.calm_position)
				var anim: Animation = $AnimationPlayer.get_animation('zoomOut')
				var key_id: int = anim.track_find_key(0,0)
				if zoomOnEnemy == true:
					anim.track_set_key_value(0, key_id, zoomLoc)
				else:
					anim.track_set_key_value(0, key_id, get_global_mouse_position())
				$AnimationPlayer.play("zoomOut")
				#$out.play()
				zoomOnEnemy = false
				#Globals.play_calm(Globals.calm_position)
				#if $AnimationPlayer.is_playing() == false:
					
			if zoom == false:
				zoom = true
				
			else:
				zoom = false
				
		
			
func get_zoomLoc(pos):
	zoomLoc = pos
	
func clicked():
	if Input.is_action_pressed("burn"):
		return true
		


func _on_spawner_timeout():
	
	var num1 = len(enemies)
	if num1 != 0:
		randomize()
		var num2 = randi() % num1
		var num = enemies[num2]
		if num == 1:
			var enemy = ENEMY.instance()
			$enemyContainer.add_child(enemy)
		elif num == 2:
			var enemy = ENEMY2.instance()
			$enemyContainer.add_child(enemy)
		elif num == 3:
			var enemy = ENEMY3.instance()
			$enemyContainer.add_child(enemy)
		enemies.erase(num)
	
func spawnAsh(pos,num):
	var ash = ASH.instance()
	add_child(ash)
	ash.position = pos
	enemies.append(num)
	


func _on_first_timeout():
	randomize()
	var num = randi() % 3
	if num == 1:
		var enemy = ENEMY.instance()
		$enemyContainer.add_child(enemy)
	elif num == 2:
		var enemy = ENEMY2.instance()
		$enemyContainer.add_child(enemy)
	elif num == 3:
		var enemy = ENEMY3.instance()
		$enemyContainer.add_child(enemy)
	enemies.erase(num)
	$first.stop()
	
func find_enemy(pos):
	for child in $enemyContainer.get_children():
		if child.position == pos:
			if child.name == 'enemy':
				Globals.play_fish(Globals.fish_position)
			elif child.name == 'enemy2':
				Globals.play_corn(Globals.corn_position)
			elif child.name == 'enemy3':
				Globals.play_bear(Globals.bear_position)
			
	


func _on_home_pressed():
	Globals.go_home()
