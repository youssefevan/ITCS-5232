extends CharacterBody3D

@onready var mesh = $Mesh
@onready var animator = $Mesh/enemy/AnimationPlayer
@onready var hitbox_collider = $Mesh/Hitbox/Collider

@export var fire_scene : PackedScene

@export var max_speed = 325
var speed
var frame = 0
var player_in_range := false

@export var attack_movement_speed := 0.0

@export var anim_speed_walk = 1.0
@export var anim_speed_attack = 1.2

@export var health := 2

@export var bones := 1

@export var drops : Array[PackedScene]

# navigation setup
@onready var nav_agent = $NavigationAgent3D
var player
var direction = Vector3.ZERO
var destination = Vector3.ZERO
var local_destination = Vector3.ZERO
var look_angle = 0
var look_friction = 5

var path_update_rate := 12

var rng = RandomNumberGenerator.new()

var on_fire := false

var player_distance : float

func _ready() -> void:
	speed = max_speed
	health += floor(World.wave/4)
	rng.randomize()
	player = get_tree().get_first_node_in_group("Player")
	animator.speed_scale = anim_speed_walk;
	animator.play("Walk")
	animator.seek(rng.randf_range(0, animator.current_animation_length))

func _physics_process(delta) -> void:
	frame += 1
	
	if !player:
		player = get_tree().get_first_node_in_group("Player")
	
	if (frame % 12) == 0: 
		player_distance = Vector2(global_position.x, global_position.z).distance_to(Vector2(player.global_position.x, player.global_position.z))
		$Label3D.text = str(int(player_distance))
	
	if player_distance < 7:
		$Label3D.modulate = Color.RED
		if (frame % 12) == 0: # update every n frames
			nav_agent.set_target_position(player.global_position)
			
			destination = nav_agent.get_next_path_position()
			local_destination = destination - global_position
			#print(local_destination)
	elif player_distance > 15:
		$Label3D.modulate = Color.WHITE
		if (frame % 60) == 0: # update every n frames
			nav_agent.set_target_position(player.global_position)
			
			destination = nav_agent.get_next_path_position()
			local_destination = destination - global_position
			#print(local_destination)
	else:
		$Label3D.modulate = Color.WHITE
		if (frame % 30) == 0: # update every n frames
			nav_agent.set_target_position(player.global_position)
			
			destination = nav_agent.get_next_path_position()
			local_destination = destination - global_position
			#print(local_destination)
	
	if on_fire and (frame % 60) == 0:
		get_hit(false)
	
	direction = local_destination.normalized()
	
	look_angle = lerp_angle(look_angle, Vector2(direction.x, direction.z).angle(), look_friction * delta)
	
	mesh.rotation.y = -look_angle + (PI/2)
	
	velocity = direction * speed * delta
	position.y = 0
	
	handle_hitbox()
	handle_death()
	
	move_and_slide()

func get_hit(fire_arrow : bool) -> void:
	health -= 1
	if fire_arrow == true and on_fire == false:
		catch_fire()

func handle_death() -> void:
	if health <= 0:
		World.bones += bones
		World.enemies_left -= 1
		
		if len(drops) > 0:
			var drop_chance = rng.randi_range(0, 99)
			if drop_chance == 0:
				var pick_drop = rng.randi_range(0, len(drops)-1)
				var drop = drops[pick_drop].instantiate()
				get_parent().add_child(drop)
				drop.global_position = global_position
		
		call_deferred("queue_free")
		
func handle_hitbox() -> void:
	if animator.current_animation == "Attack":
		if animator.current_animation_position >= 0.6 and animator.current_animation_position <= 0.7:
			hitbox_collider.disabled = false
		else:
			hitbox_collider.disabled = true

func catch_fire() -> void:
	if on_fire == false:
		var fire = fire_scene.instantiate()
		add_child(fire)
		fire.position.y = 0.75
	on_fire = true

func _on_melee_range_body_entered(body) -> void:
	if body.get_collision_layer_value(2):
		player_in_range = true
		speed = attack_movement_speed
		animator.speed_scale = anim_speed_attack
		animator.play("Attack")

func _on_melee_range_body_exited(body) -> void:
	if body.get_collision_layer_value(2):
		player_in_range = false

func _on_animation_player_animation_finished(anim_name) -> void:
	if anim_name == "Attack":
		if !player_in_range:
			speed = max_speed
			animator.speed_scale = anim_speed_walk
			animator.play("Walk")
		else:
			speed = attack_movement_speed
			animator.speed_scale = anim_speed_attack
			animator.play("Attack")

func _on_hitbox_body_entered(body) -> void:
	if body.get_collision_layer_value(2):
		World.player_health -= 1
