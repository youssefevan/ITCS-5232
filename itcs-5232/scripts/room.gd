extends Node2D
class_name Room

@export var background_tiles : TileMapLayer
@export var wall_tiles : TileMapLayer
@export var scene_tiles : TileMapLayer

@export var layout_texture : Texture2D

@export var wall_color : Color

var id : Vector2

var room_size = Vector2(192 * 8, 144 * 8)

var neighbors = []
var closing_wall_coordinates = {
	Vector2.UP: [
			Vector2(10, 0), Vector2(11, 0), Vector2(12, 0), Vector2(13, 0)
		],
	Vector2.DOWN: [
			Vector2(10, 17), Vector2(11, 17), Vector2(12, 17), Vector2(13, 17)
		],
	Vector2.LEFT: [
			Vector2(0, 7), Vector2(0, 8), Vector2(0, 9), Vector2(0, 10)
		],
	Vector2.RIGHT: [
			Vector2(23, 7), Vector2(23, 8), Vector2(23, 9), Vector2(23, 10)
		]
}

func _ready():
	var game = get_parent().get_parent()
	
	build_room()

func change_tile_color(new_color : Color):
	pass

func build_room():
	var layout = layout_texture.get_image()
	
	for x in layout_texture.get_width()-1:
		for y in layout_texture.get_height()-1:
			var pixel_color = layout.get_pixel(x, y)
			if pixel_color == wall_color:
				wall_tiles.set_cell(Vector2(x, y), 0, Vector2(7, 7))
	
	for dir in Global.directions:
		var neighbor =  id + dir
		if neighbor in Global.rooms:
			neighbors.append(neighbor)
		else:
			var tile_positions = closing_wall_coordinates[dir]
			for pos in tile_positions:
				wall_tiles.set_cell(pos, 0, Vector2(7, 7))
	print(neighbors)
