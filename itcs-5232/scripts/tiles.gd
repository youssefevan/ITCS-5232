extends Node2D

@onready var walls = $Walls
@onready var bg = $Background

@export var level_size : Vector2
var cell_size = 8
var rng = RandomNumberGenerator.new()

var used_cells = []
var borders
var astar_grid

func _ready():
	level_size = level_size/cell_size
	borders = Rect2(1, 1, level_size.x - 2, level_size.y - 2) 
	
	rng.randomize()
	
	generate_level()
	generate_astar_grid()

func generate_level():
	var walker_steps = 1024
	# create new walker, get map, delete walker
	var walker = Walker.new(floor(level_size/2), borders)
	var map = walker.walk(walker_steps)
	walker.queue_free()
	
	for cell in map:
		walls.erase_cell(cell)

func generate_astar_grid():
	astar_grid = AStarGrid2D.new()
	astar_grid.region = walls.get_used_rect()
	astar_grid.cell_size = Vector2i(cell_size, cell_size)
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar_grid.update()
	
	var region_size = astar_grid.region.size
	var region_position = astar_grid.region.position
	
	for x in region_size.x:
		for y in region_size.y:
			var tile_position = Vector2i(x + region_position.x, y + region_position.y)
			
			var tile_data = walls.get_cell_tile_data(tile_position)
			
			if tile_data != null:
				astar_grid.set_point_solid(tile_position)
