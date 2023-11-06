extends CanvasLayer


@onready var label_result = $VBoxContainer/Label2
@onready var label_best_result = $VBoxContainer/Label3

var state_mode = 0 

func _ready():
		label_result.set_text("Ваш результат: " + format_time(Globals.result))
		label_best_result.set_text("Ваш лучший результат: " + format_time(Globals.best_result))
	

func _on_restart_button_pressed():
	get_tree().reload_current_scene()
	queue_free()

func format_time(seconds):
		var minutes = int(seconds / 60)
		var sec = int(seconds - minutes * 60)
		return "%2d:%02d" % [minutes, sec]	

