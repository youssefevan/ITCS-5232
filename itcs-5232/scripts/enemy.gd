extends CharacterBody3D

@onready var mesh = $Mesh
@onready var animator = $Mesh/enemy/AnimationPlayer
@onready var hitbox_collider = $Mesh/Hitbox/Collider

@export var max_speed = 325
var speed
var frame = 0
var player_in_range := false

@export var anim_speed_walk = 1.0
@export var anim_speed_attack = 1.2

@export var health := 2

@export var bones := 1

# navigation setup
@onready var nav_agent = $NavigationAgent3D
var player
var direction = Vector3.ZERO
var destination = Vector3.ZERO
var local_destination = Vector3.ZERO
var look_angle = 0
var look_friction = 5

var rng = RandomNumberGenerator.new()

func _ready():
	speed = max_speed
	rng.randomize()
	player = get_tree().get_first_node_in_group("Player")
	animator.speed_scale = anim_speed_walk;
	animator.play("Walk")
	animator.seek(rng.randf_range(0, animator.current_animation_length))

func _physics_process(delta):
	frame += 1
	
	if !player:
		player = get_tree().get_first_node_in_group("Player")
	
	if (frame % 12) == 0: # update every n frames
		nav_agent.set_target_position(player.global_position)
		
		destination = nav_agent.get_next_path_position()
		local_destination = destination - global_position
		#print(local_destination)
		
	direction = local_destination.normalized()
	
	look_angle = lerp_angle(look_angle, Vector2(direction.x, direction.z).angle(), look_friction * delta)
	
	mesh.rotation.y = -look_angle + (PI/2)
	
	velocity = direction * speed * delta
	position.y = 0
	
	handle_hitbox()
	handle_death()
	
	move_and_slide()

func handle_death():
	if health <= 0:
		World.bones += 2
		World.enemies_left -= 1
		call_deferred("queue_free")
		
func handle_hitbox():
	if animator.current_animation == "Attack":
		if animator.current_animation_position >= 0.6 and animator.current_animation_position <= 0.7:
			hitbox_collider.disabled = false
		else:
			hitbox_collider.disabled = true

func _on_melee_range_body_entered(body):
	if body.get_collision_layer_value(2):
		player_in_range = true
		speed = 0
		animator.speed_scale = anim_speed_attack
		animator.play("Attack")

func _on_melee_range_body_exited(body):
	if body.get_collision_layer_value(2):
		player_in_range = false

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Attack":
		if !player_in_range:
			speed = max_speed
			animator.speed_scale = anim_speed_walk
			animator.play("Walk")
		else:
			speed = 0
			animator.speed_scale = anim_speed_attack
			animator.play("Attack")

func _on_hitbox_body_entered(body):
	if body.get_collision_layer_value(2):
		World.player_health -= 1
