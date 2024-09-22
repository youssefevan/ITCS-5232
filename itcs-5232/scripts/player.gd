extends Area2D
class_name Player

@onready var ray = $PhysicsRay
@onready var attack_handler = $AttackHandler

@export var attack_scene : PackedScene

var last_movement_direction

var colors = {
	"fire": Color.RED,
	"ice": Color.CYAN,
	"magic": Color.MAGENTA,
	"necrotic": Color.GREEN,
}

var tile_size = 8
var animation_speed = 5
var moving = false
var attacking = false

var inputs = {"right": Vector2.RIGHT,
			"left": Vector2.LEFT,
			"up": Vector2.UP,
			"down": Vector2.DOWN}

var active_inputs = []

var current_room

func _physics_process(delta):
	if !attacking:
		handle_movement()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("attack"):
		if !attacking:
			enter_attack()
		else:
			exit_attack()

func handle_movement():
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
		last_movement_direction = dir
	elif ray.get_collider() is TileMap:# or ray.get_collider() is Enemy:
		pass

func movement_tween(dir):
	var tween = create_tween()
	tween.tween_property(self, "position", position + inputs[dir] * tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
	moving = true
	await tween.finished
	moving = false

func enter_attack():
	attacking = true
	active_inputs = []
	
	var attack = attack_scene.instantiate()
	attack.type = attack.types.ICE
	attack.color = colors["ice"]
	attack_handler.add_child(attack)
	attack.position.y -= tile_size

func exit_attack():
	attacking = false
	for child in attack_handler.get_children():
		child.call_deferred("free")


func _on_area_entered(area):
	if area.get_collision_layer_value(7):
		
		if last_movement_direction:# and area.get_parent().room_position != current_room:
			#current_room = area.get_parent().room_position
			get_parent().advance_camera(inputs[last_movement_direction])
