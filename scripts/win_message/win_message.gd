extends CanvasLayer


@onready var label_result = $VBoxContainer/Label2
@onready var label_best_result = $VBoxContainer/Label3

func _ready():
	label_result.set_text("Ваш результат: " + str(Globals.result) + " секунд")
	label_best_result.set_text("Ваш лучший результат: " + str(Globals.best_result) + " секунд")

func _on_restart_button_pressed():
	get_tree().reload_current_scene()
	queue_free()

