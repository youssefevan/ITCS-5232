extends Area2D
class_name Enemy

@export var speed : float
@export var max_health : int

@export var animation_speed := 5.0

var room
var astar

var moving := false

var astar_path = []

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)
	set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("attack"):
		var player = get_tree().get_first_node_in_group("Player")
		var player_position = player.global_position/Vector2(8, 8)
		var this_position = (global_position/Vector2(8, 8)) + Vector2(4, 4)
		var room_position = (room.id * room.room_size) / Vector2(8, 8)
		var position_relative_to_astar_region = (this_position - room_position)/Vector2(8, 8)
		var player_position_relative_to_astar_region = (player_position - room_position)/Vector2(8, 8)
		
		var path = astar.get_point_path(position_relative_to_astar_region, player_position_relative_to_astar_region)
		print(path[1]/Vector2(8, 8))
		
		for i in path:
			astar_path.append(i)
		
		var target_dir = (astar_path.front()/Vector2(8, 8)) - position_relative_to_astar_region
		print(target_dir)
		
		movement_tween(target_dir * Vector2(8, 8))
		
		astar_path.pop_front()
		
		#print("-------------------------")
		#print("R:", room_position)
		#print("E", this_position)
		#print("P", player_position)
		#print("ER", position_relative_to_astar_region)
		#print("PR", player_position_relative_to_astar_region)

func movement_tween(dir):
	var tween = create_tween()
	tween.tween_property(self, "position", dir, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
	moving = true
	await tween.finished
	moving = false

func _on_area_entered(area):
	if area.get_collision_layer_value(7):
		room = area.get_parent()
		astar = room.astar_grid

func _on_visible_on_screen_notifier_2d_screen_entered():
	set_physics_process(true)
	set_process(true)


func _on_visible_on_screen_notifier_2d_screen_exited():
	set_physics_process(false)
	set_process(false)
