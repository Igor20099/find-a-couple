extends Node2D

var colors = [
	Color.WHITE,
	Color.WHITE,
	Color.GREEN,
	Color.GREEN,
	Color.RED,
	Color.RED,
	Color.BLUE,
	Color.BLUE,
	Color.YELLOW,
	Color.YELLOW,
	Color.PINK,
	Color.PINK,
	Color.DARK_VIOLET,
	Color.DARK_VIOLET,
	Color.CHOCOLATE,
	Color.CHOCOLATE
	]

var seconds = Globals.GAME_TIME
var game_over_message = preload('res://ui/game_over_message.tscn')
var win_message = preload('res://ui/win_message.tscn')
@onready var game_timer = $GameTimer	
@onready var label = $CanvasLayer/MarginContainer/VBoxContainer/MarginContainer/Label
@onready var buttons = get_tree().get_nodes_in_group('buttons')
@onready var audio_player = $AcceptSound
@onready var cancel_player = $CanselSound 
var save_path = 'user://best_score.save'
var minutes = 0
var sec = 0

func _ready():
	load_data()
	colors.shuffle()
	set_colors_in_buttons(colors,buttons)
	Events.compare_colors.connect(compare_colors)
	Events.win.connect(win)
	Events.game_over.connect(game_over)
	show_timer(Globals.GAME_TIME)


func set_colors_in_buttons(colors,buttons):
	for btn in buttons:
		var color_rect = btn.get_child(0)
		color_rect.set_color(colors.pop_back())
		

func compare_colors(color_first,color_second):
	if Globals.color_first == Globals.color_second:
		Globals.opened_color +=1
		print(Globals.opened_color)
		await get_tree().create_timer(0.3).timeout
		audio_player.play()
		Events.win.emit()
	elif Globals.color_first != Globals.color_second:
		set_buttons_disable(true)
		await get_tree().create_timer(0.5).timeout
		set_buttons_disable(false)
		set_visible_colors(false)
		cancel_player.play()
		Globals.opened_color = 0
		print(Globals.opened_color)
	Globals.color_first = null
	Globals.color_second = null		
	
func set_visible_colors(visible):
	for btn in buttons:
		btn.get_child(0).set_visible(visible)	


func _on_game_timer_timeout():
	seconds -=1
	show_timer(seconds)
	
	if seconds == -1:
		game_timer.stop()
		Events.game_over.emit()

func game_over():
	var game_over = game_over_message.instantiate()
	add_child(game_over)
	Globals.color_first = null
	Globals.color_second = null	
	
func win():
	if Globals.opened_color == Globals.COLORS_COUNT:
		game_timer.stop()
		Globals.result = Globals.GAME_TIME - seconds
		if Globals.best_result == 0:
			Globals.best_result = Globals.result
			save(Globals.result)
		elif Globals.best_result < Globals.result:
			load_data()
		elif Globals.best_result > Globals.result:
			Globals.best_result = Globals.result
			save(Globals.best_result)
		var win = win_message.instantiate()
		add_child(win)
		Globals.color_first = null
		Globals.color_second = null	
		
func save(result):
	var file = FileAccess.open(save_path,FileAccess.WRITE)
	file.store_var( result)
	
func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path,FileAccess.READ)
		Globals.best_result = file.get_var( Globals.best_result)
		
func set_buttons_disable(is_disabled):
	for btn in buttons:
		btn.disabled = is_disabled
	
func show_timer(seconds):
		minutes = int(seconds / 60)
		sec = int(seconds - minutes * 60)
		label.text = "%2d:%02d" % [minutes, sec]
