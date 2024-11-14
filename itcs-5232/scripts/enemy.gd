extends CharacterBody3D

@onready var mesh = $Mesh

var speed = 250
var frame = 0

var health := 3

# navigation setup
@onready var nav_agent = $NavigationAgent3D
var player
var direction = Vector3.ZERO
var destination = Vector3.ZERO
var local_destination = Vector3.ZERO
var look_angle = 0
var look_friction = 5

func _ready():
	player = get_tree().get_first_node_in_group("Player")

func _physics_process(delta):
	frame += 1
	
	if !player:
		player = get_tree().get_first_node_in_group("Player")
	
	if (frame % 8) == 0: # update every 8 frames
		if global_position.distance_to(player.global_position) < 30:
			nav_agent.set_target_position(player.global_position)
		
		destination = nav_agent.get_next_path_position()
		local_destination = destination - global_position
		#print(local_destination)
		
	direction = local_destination.normalized()
	
	look_angle = lerp_angle(look_angle, Vector2(direction.x, direction.z).angle(), look_friction * delta)
	
	mesh.rotation.y = -look_angle + (PI/2)
	
	velocity = direction * speed * delta
	position.y = 0
	
	handle_death()
	
	move_and_slide()

func handle_death():
	if health <= 0:
		World.bones += 200
		call_deferred("queue_free")
