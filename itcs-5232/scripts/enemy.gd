extends Area2D
class_name Enemy

@export var speed : float
@export var max_health : int

var astar_grid
var room

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)
	set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func setup_grid():
	astar_grid = AStarGrid2D.new()
	astar_grid.region = room.wall_tiles.get_used_rect()
	astar_grid.cell_size = Vector2i(8, 8)
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar_grid.default_compute_heuristic = 1 # manhattan
	astar_grid.update()
	
	var region_size = astar_grid.region.size
	var region_position = astar_grid.region.position
	
	for x in region_size.x:
		for y in region_size.y:
			var tile_position = Vector2i(x + region_position.x, y + region_position.y)
			
			var tile_data = room.wall_tiles.get_cell_tile_data(tile_position)
			
			if tile_data != null:
				astar_grid.set_point_solid(tile_position)

func _on_area_entered(area):
	if area.get_collision_layer_value(7):
		room = area.get_parent()
		setup_grid()


func _on_visible_on_screen_notifier_2d_screen_entered():
	set_physics_process(true)
	set_process(true)


func _on_visible_on_screen_notifier_2d_screen_exited():
	set_physics_process(false)
	set_process(false)
