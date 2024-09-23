extends Node

var rooms = []

var directions = [
	Vector2.UP,
	Vector2.DOWN,
	Vector2.LEFT,
	Vector2.RIGHT
]

func set_rooms(new_rooms : Array) -> void:
	rooms = new_rooms
