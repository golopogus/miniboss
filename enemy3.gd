extends Node2D

var ySpawnMin = -10
var ySpawnMax = 610

var xSpawnMin = -10
var xSpawnMax = 1034

var xSpawn = 0
var ySpawn = 0

var xMovePos = 1024
var yMovePos = 600

var started = 0
var MovePos = Vector2()

var p0 = Vector2()
var p1 = Vector2()
var state = 0
var inside = false
var enemies = ['bearly','fishy','huskorn']


func _ready():
	randomize()
	#var sprite_choice = randi() % 3
	#$spriteContainer.get_children()[sprite_choice].show()
	#self.name = enemies[sprite_choice]
	
	var pos_positions = randi() % 4 
	#print(pos_positions)
	if pos_positions == 1:
		ySpawn = ySpawnMin
		xSpawn = randf() * xSpawnMax
	elif pos_positions == 2:
		ySpawn = ySpawnMax
		xSpawn = randf() * xSpawnMax
	elif pos_positions == 3:
		xSpawn = xSpawnMin
		ySpawn = randf() * ySpawnMax
	else:
		xSpawn = xSpawnMax
		ySpawn = randf() * ySpawnMax
	
	position = Vector2(xSpawn,ySpawn)

	
func _process(delta):
	#print(MovePos)
	
	if Input.is_action_pressed("burn") and inside == true:
		change_state()
		Globals.stop_squeak()
		Globals.bear_position = 0
	if started == 0:
		
		MovePos = initialMovePos(MovePos)
		p1 = initialMovePos(MovePos)
	
	if state == 0:
		
		var posDiff = sqrt(pow(global_position.x - MovePos.x,2) + pow(global_position.y - MovePos.y,2))
		#print(MovePos)
		if posDiff <= 10:
			global_position = MovePos
		
		else:
			translate(get_velocity(MovePos)*delta)
			
	if state == 1:
		#var new_pos = rand_pos()
		p0 = position
		#p1 = rand_pos()
		#p2 = rand_pos()
		#print(p1)
		var posDiff = sqrt(pow(global_position.x - p1.x,2) + pow(global_position.y - p1.y,2))
		#print(MovePos)
		if posDiff <= 10:
			p1 = rand_pos()
		
		else:
			translate(get_velocity(p1)*delta)
		
		
		
		#move2Point()
		
		
		
		
		
		
func get_velocity(pos):
	
	var speed = 400
	var angle = get_angle_to(pos)
	
	var direction = Vector2(cos(angle),sin(angle))
	var velocity = direction * speed
	
	return velocity
	
func initialMovePos(pos):
	
	
	pos.x = randf() * xMovePos
	pos.y = randf() * yMovePos
	started = 1
	
	return pos
	

		
	
	
func rand_pos():
	randomize()
	var numX = randf() * xMovePos
	var numY = randf() * yMovePos
	
	return Vector2(numX,numY)
	

func change_state():
	
	state = 1
	
func _on_Area2D_mouse_entered():
	inside = true
	get_parent().get_parent().get_zoomLoc(global_position)


func _on_Area2D_mouse_exited():
	inside = false
	get_parent().get_parent().get_zoomLoc(Vector2(-1000,-1000))


func _on_hit_mouse_entered():
	if get_parent().get_parent().clicked():
		start_death()
		$fire.play()

func start_death():
	$Particles2D.emitting = true
	$Timer.start()

func _on_Timer_timeout():
	get_parent().get_parent().spawnAsh(global_position,3)
	Globals.stop_squeak()
	Globals.bear_position = 0
	queue_free()
	


func _on_hit_mouse_exited():
	pass # Replace with function body.
	
func reset_pos():
	Globals.bear_position = 0
