@icon("res://sprites/editor_icons/room.png")
extends Node2D
class_name Room

@export_category("Tiles")
@export var background_tiles : TileMapLayer
@export var wall_tiles : TileMapLayer

@export_category("Layouts")
@export var layout_textures : Array[Texture2D]

@export_category("Colors")
@export var wall_color : Color
@export var enemy_color : Color
@export var item_color : Color

@export_category("Spawners")
@export var enemy_spawner_scene : PackedScene
@export var item_spawner_scene : PackedScene

var id : Vector2

var room_size = Vector2(192 * 8, 144 * 8)

var rng = RandomNumberGenerator.new()

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
	rng.randomize()
	build_room()

func build_room():
	var spawn_texture = layout_textures[0]
	var random_texure = layout_textures[rng.randi_range(1, len(layout_textures)-1)]
	var texture
	
	if id != Vector2.ZERO:
		texture = random_texure
	else:
		texture = spawn_texture
		
	var layout = texture.get_image()
	for x in texture.get_width()-1:
		for y in texture.get_height()-1:
			var pixel_color = layout.get_pixel(x, y)
			set_layout(pixel_color, Vector2(x, y))
		
	for dir in Global.directions:
		var neighbor =  id + dir
		if neighbor in Global.rooms:
			neighbors.append(neighbor)
		else:
			var tile_positions = closing_wall_coordinates[dir]
			for pos in tile_positions:
				wall_tiles.set_cell(pos, 0, Vector2(7, 7))
	#print(neighbors)

func set_layout(color, pos):
	match color:
		wall_color:
			wall_tiles.set_cell(pos, 0, Vector2(7, 7))
		enemy_color:
			var enemy = enemy_spawner_scene.instantiate()
			add_child(enemy)
			enemy.position = pos * 8
		item_color:
			var item = item_spawner_scene.instantiate()
			add_child(item)
			item.position = pos * 8
