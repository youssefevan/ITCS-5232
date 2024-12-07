extends Node3D

@onready var enemy_scene = preload("res://scenes/enemy.tscn")
@onready var enemy_slow_scene = preload("res://scenes/enemy_slow.tscn")
@onready var enemy_fast_scene = preload("res://scenes/enemy_fast.tscn")

@export var unlock_wave := 0

var frame := 0
var locked := true
var spawn_amount : int
var start_wave := false

var locations = []
var location_index := 0

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	
	for child in get_children():
		locations.append(child)
		child.get_child(0).visible = false

func _physics_process(delta):
	frame += 1
	
	if (frame % (40 * 1)) == 0 and spawn_amount > 0 and start_wave == true:
		if location_index < len(locations)-1:
			location_index += 1
		else:
			location_index = 0
		
		var enemy_type = rng.randi_range(0, 30)
		
		if enemy_type <= 3 and unlock_wave >= 5:
			spawn_enemy_fast()
		elif enemy_type <= 6 and enemy_type > 3 and unlock_wave >= 3:
			spawn_enemy_slow()
		else:
			spawn_enemy()
		
		spawn_amount -= 1

func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	get_tree().get_root().add_child(enemy)
	enemy.global_position = locations[location_index].global_position

func spawn_enemy_slow():
	var enemy = enemy_slow_scene.instantiate()
	get_parent().add_child(enemy)
	enemy.global_position = locations[location_index].global_position

func spawn_enemy_fast():
	var enemy = enemy_fast_scene.instantiate()
	get_parent().add_child(enemy)
	enemy.global_position = locations[location_index].global_position
