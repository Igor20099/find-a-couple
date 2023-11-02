extends Node2D


@onready var animation_player = $CanvasLayer/MarginContainer/VBoxContainer/Label2/AnimationPlayer
func _ready():
	animation_player.play('text_transperent')
	

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		get_tree().change_scene_to_file("res://scenes/game.tscn")

