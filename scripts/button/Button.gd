extends Button


@onready var audio_opened = get_tree().get_root().get_child(2).get_child(2)

func _on_pressed():
	audio_opened.play()
	var color_rect = get_child(0)
	color_rect.set_visible(true)
	if Globals.color_first == null:
		Globals.color_first = color_rect.get_color()
		print(Globals.color_first)
	elif Globals.color_first != null:
		Globals.color_second = color_rect.get_color()
		print(Globals.color_second)
	if Globals.color_first != null and Globals.color_second != null:
		Events.compare_colors.emit(Globals.color_first,Globals.color_second)
	
		
