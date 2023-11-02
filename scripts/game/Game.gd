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

func _ready():
	
	colors.shuffle()
	set_colors_in_buttons(colors,buttons)
	Events.compare_colors.connect(compare_colors)
	Events.win.connect(win)
	Events.game_over.connect(game_over)
	label.text = str(Globals.GAME_TIME)

func _process(delta):
	pass

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
		await get_tree().create_timer(0.5).timeout
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
	label.text = str(seconds)
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
		var win = win_message.instantiate()
		add_child(win)
		Globals.color_first = null
		Globals.color_second = null	
