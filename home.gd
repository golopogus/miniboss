extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#func _ready():
	#Globals.get_node('menu').play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_play_pressed():
	Globals.start_game()


func _on_instruct_pressed():
	Globals.go_instruct()
