extends Node
var calm_position = 0
var zoomCheck = 0
func play_calm(pos):
	$calm.play(calm_position)
func stop_calm():
	calm_position = $calm.get_playback_position()
	$calm.stop()

func _unhandled_input(event):
	if Input.is_action_just_pressed("zoom"):
		if $calm.playing == true:
			calm_position = $calm.get_playback_position()
			$calm.stop()
		elif $calm.playing == false:
			$calm.play(calm_position)
#	if Input.is_action_just_pressed("zoom"):
#		if zoomCheck == 0:
#			calm_position = $calm.get_playback_position()
#			$calm.stop()
#			#zoomCheck = 1
#		else:
			
			#zoomCheck = 0
		
		
		
	
	#$calm.play(calm_position)
