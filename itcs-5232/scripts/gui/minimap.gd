extends Node2D

func _ready() -> void:
	build_minimap()

func build_minimap():
	for room in Global.rooms:
		#print(room)
		$TileMap.set_cell(room, 2, Vector2(6, 7))
