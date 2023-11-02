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
	for btn in buttons:
		var color_rect = btn.get_child(0)
		color_rect.set_color(colors.pop_back())
		color_rect.set_visible(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

		
