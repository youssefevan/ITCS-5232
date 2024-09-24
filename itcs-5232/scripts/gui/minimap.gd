extends Node2D

var current_room
var seen_rooms = []

func _ready() -> void:
	$TileMap.clear()
	current_room = Vector2.ZERO
	$TileMap.set_cell(current_room, 2, Vector2(0, 0))
	seen_rooms.append(current_room)

func _process(delta):
	if Global.occupied_room != current_room:
		$TileMap.set_cell(current_room, 2, Vector2(6, 7))
		$TileMap.set_cell(Global.occupied_room, 2, Vector2(0, 0))
		current_room = Global.occupied_room
		seen_rooms.append(current_room)
