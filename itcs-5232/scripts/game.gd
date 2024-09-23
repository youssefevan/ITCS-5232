extends Node2D

enum whose_turn {PLAYER, ENEMY}

var active_entities = []

@export var player : Player
@export var camera : Camera2D

@onready var rooms = $Rooms

@onready var room_scene = preload("res://scenes/room.tscn")

var room_variants = []

var available_room_spaces = []
var number_of_rooms_to_spawn := 12

var existing_rooms = []

var rng = RandomNumberGenerator.new()

var directions = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]

var level_size = 4

func _ready():
	rng.randomize()
	generate_level()

func generate_level():
	available_room_spaces = []
	for child in rooms.get_children():
		child.call_deferred("free")
	
	existing_rooms.append(Vector2(0, 0))
	for dir in directions:
		available_room_spaces.append(dir)
	
	for i in number_of_rooms_to_spawn: 
		choose_room_space()
	
	spawn_rooms()

func choose_room_space():
	var chosen_space = rng.randi_range(0, len(available_room_spaces)-1)
	existing_rooms.append(available_room_spaces[chosen_space])
	available_room_spaces.remove_at(chosen_space)
	
	for dir in directions:
		var this_space = existing_rooms.back()
		var target_space = this_space + dir
		
		if !(target_space in available_room_spaces):
			if !(target_space in existing_rooms):
				if !(target_space.x >= level_size or target_space.x < -level_size) and !(target_space.y >= level_size or target_space.y < -level_size):
						available_room_spaces.append(target_space)
	
	#print(existing_rooms)
	Global.set_rooms(existing_rooms)

func spawn_rooms():
	for room in existing_rooms:
		var r = room_scene.instantiate()
		rooms.add_child(r)
		r.global_position = room * r.room_size

func start_turn() -> void:
	pass

func end_turn() -> void:
	active_entities = []

func advance_camera(direction):
	var tween = camera.create_tween() # make child of camera b/c camera process mode is seet to always
	tween.tween_property(camera, "position", camera.position + (direction * Vector2(192, 144)), 1.0).set_trans(Tween.TRANS_LINEAR)
	get_tree().paused = true
	await tween.finished
	get_tree().paused = false
	#camera.position += Vector2(192, 144) * direction
