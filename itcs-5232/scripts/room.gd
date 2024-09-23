extends Node2D
class_name Room

@export var background_tiles : TileMapLayer
@export var wall_tiles : TileMapLayer
@export var scene_tiles : TileMapLayer

@export var layout_texture : Texture2D

@export var wall_color : Color

var room_size = Vector2(192 * 8, 144 * 8)

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
