extends Node3D

@onready var enemy_scene = preload("res://scenes/enemy.tscn")

@export var unlock_wave := 0

var frame := 0
var locked := true
var spawn_amount : int
var start_wave := false

var locations = []
var location_index := 0

func _ready():
	for child in get_children():
		locations.append(child)
		child.get_child(0).visible = false

func _physics_process(delta):
	frame += 1
	
	if (frame % (20 * 1)) == 0 and spawn_amount > 0 and start_wave == true:
		if location_index < len(locations)-1:
			location_index += 1
		else:
			location_index = 0
		
		var enemy = enemy_scene.instantiate()
		get_parent().add_child(enemy)
		enemy.global_position = locations[location_index].global_position
		spawn_amount -= 1
