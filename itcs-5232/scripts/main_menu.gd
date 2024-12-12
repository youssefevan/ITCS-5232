extends Node3D

@onready var world = preload("res://scenes/world.tscn")

func _on_play_pressed():
	get_tree().change_scene_to_packed(world)
