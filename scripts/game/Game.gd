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
@onready var buttons = get_tree().get_nodes_in_group('buttons')
# Called when the node enters the scene tree for the first time.
func _ready():
	
	colors.shuffle()
	set_colors_in_buttons(colors,buttons)
	Events.compare_colors.connect(compare_colors)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_colors_in_buttons(colors,buttons):
	for btn in buttons:
		var color_rect = btn.get_child(0)
		color_rect.set_color(colors.pop_back())
		

func compare_colors(color_first,color_second):
	if Globals.color_first != Globals.color_second:
		await get_tree().create_timer(1.0).timeout
		set_visible_colors(false)
	Globals.color_first = null
	Globals.color_second = null		
	
func set_visible_colors(visible):
	for btn in buttons:
		btn.get_child(0).set_visible(visible)	
