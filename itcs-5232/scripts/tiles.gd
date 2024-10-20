extends Node2D

@onready var walls = $Walls
@onready var bg = $Background

@export var level_size : Vector2
var cell_size = 8
var rng = RandomNumberGenerator.new()

var used_cells = []
var borders

func _ready():
	level_size = level_size/cell_size
	borders = Rect2(1, 1, level_size.x - 2, level_size.y - 2) 
	
	rng.randomize()
	
	generate_level()

func generate_level():
	var walker_steps = 1024
	# create new walker, get map, delete walker
	var walker = Walker.new(floor(level_size/2), borders)
	var map = walker.walk(walker_steps)
	walker.queue_free()
	
	for cell in map:
		walls.erase_cell(cell)
