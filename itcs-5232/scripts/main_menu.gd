extends Node3D

@onready var world = preload("res://scenes/world.tscn")

func _ready():
	get_tree().paused = false

func _on_play_pressed():
	World.reset_variables()
	get_tree().change_scene_to_file('res://scenes/world.tscn')

func _on_exit_pressed():
	get_tree().quit()
