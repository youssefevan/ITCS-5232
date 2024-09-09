extends Area2D
class_name Player

@onready var ray = $PhysicsRay

var tile_size = 8
var animation_speed = 5
var moving = false

var inputs = {"right": Vector2.RIGHT,
			"left": Vector2.LEFT,
			"up": Vector2.UP,
			"down": Vector2.DOWN}

var active_inputs = []

func movement_tween(dir):
	var tween = create_tween()
	tween.tween_property(self, "position", position + inputs[dir] * tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
	moving = true
	await tween.finished
	moving = false

func _physics_process(delta):
	for dir in inputs.keys():
		if Input.is_action_pressed(dir):
			if dir in active_inputs:
				pass
			else:
				active_inputs.append(dir)
		elif Input.is_action_just_released(dir):
			if dir in active_inputs:
				active_inputs.erase(dir)
	
	if len(active_inputs) > 0 and !moving:
		move(active_inputs.back())

func move(dir):
	ray.target_position = inputs[dir] * tile_size
	
	ray.force_raycast_update()
	if !ray.is_colliding():
		movement_tween(dir)
	elif ray.get_collider() is TileMap:# or ray.get_collider() is Enemy:
		pass
