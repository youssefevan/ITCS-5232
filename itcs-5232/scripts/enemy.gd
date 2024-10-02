extends Area2D
class_name Enemy

@export var speed : float
@export var max_health : int

var room

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)
	set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	if area.get_collision_layer_value(7):
		room = area.get_parent()
		print(room.astar_grid.region)


func _on_visible_on_screen_notifier_2d_screen_entered():
	set_physics_process(true)
	set_process(true)


func _on_visible_on_screen_notifier_2d_screen_exited():
	set_physics_process(false)
	set_process(false)
