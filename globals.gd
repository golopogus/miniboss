extends Node
var calm_position = 0
var zoomCheck = 0
var voice_playing = false
var corn_position = 0
var fish_position = 0
var bear_position = 0
func _ready():
	$menu.play()
func play_calm(pos):
	$calm.play(pos)
func stop_calm():
	calm_position = $calm.get_playback_position()
	$calm.stop()

func play_boss():
	$boss.play()
func stop_boss():
	$boss.stop()

func play_bear(pos):
	$bear.play(pos)
	voice_playing = true

func play_fish(pos):
	$fish.play(pos)
	voice_playing = true

func play_corn(pos):
	$corn.play(pos)
	voice_playing = true
	
func stop_corn():
	corn_position = $corn.get_playback_position()
	$corn.stop()
	voice_playing = false

func stop_fish():
	fish_position = $fish.get_playback_position()
	$fish.stop()
	voice_playing = false

func stop_bear():
	bear_position = $bear.get_playback_position()
	$bear.stop()
	voice_playing = false

func play_squeak():
	$squeak.play()
func stop_squeak():
	$squeak.stop()
	
func start_game():
	get_tree().change_scene("res://level.tscn")
func go_home():
	get_tree().change_scene("res://home.tscn")
	$calm.stop()
	if $menu.playing == false:
		$menu.play()
func go_instruct():
	get_tree().change_scene("res://instruct.tscn")
	
	

#func _unhandled_input(event):
#	if Input.is_action_just_pressed("zoom"):
#		if $calm.playing == true:
#			calm_position = $calm.get_playback_position()
#			$calm.stop()
#		elif $calm.playing == false:
#			$calm.play(calm_position)
#	if Input.is_action_just_pressed("zoom"):
#		if zoomCheck == 0:
#			calm_position = $calm.get_playback_position()
#			$calm.stop()
#			#zoomCheck = 1
#		else:
			
			#zoomCheck = 0
		
		
		
	
	#$calm.play(calm_position)
