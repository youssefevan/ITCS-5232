extends Node3D

@onready var enemy_scene = preload("res://scenes/enemy.tscn")

var frame := 0

func _physics_process(delta):
	frame += 1
	
	if (frame % (60 * 5)) == 0:
		var enemy = enemy_scene.instantiate()
		get_parent().add_child(enemy)
		enemy.global_position = global_position
