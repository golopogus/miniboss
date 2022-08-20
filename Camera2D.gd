extends Camera2D

func get_offset_pos_start():
	offset = Vector2(512,300)
func get_offset_pos():
	offset = get_global_mouse_position()
