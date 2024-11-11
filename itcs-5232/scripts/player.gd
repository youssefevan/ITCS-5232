extends CharacterBody3D

var ray_origin = Vector3()
var ray_target = Vector3()

const MAX_SPEED = 400

var input_dir : Vector3

func _physics_process(delta):
	handle_aim()
	
	input_dir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_dir.z = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_dir.y = 0
	
	velocity = MAX_SPEED * input_dir * delta
	
	move_and_slide()

func handle_aim():
	var mouse_pos = get_viewport().get_mouse_position()
	ray_origin = $Camera.project_ray_origin(mouse_pos)
	ray_target = ray_origin + $Camera.project_ray_normal(mouse_pos) * 2000
	
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_target)
	query.collision_mask = -2147483648
	query.collide_with_areas = true
	var intersection = space_state.intersect_ray(query)
	
	if not intersection.is_empty():
		var pos = intersection.position
		var look_to = Vector3(pos.x, position.y, pos.z)
		
		$Model.look_at(look_to, Vector3.UP)
		
		# lock x and z axis
		$Model.rotation.x = 0
		$Model.rotation.z = 0
