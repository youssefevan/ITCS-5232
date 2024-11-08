extends CharacterBody3D

const SPEED = 7.0
const ACCEL = 10.0

var input_dir : Vector3

func _physics_process(delta):
	input_dir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_dir.z = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	input_dir = input_dir.normalized()
	
	velocity.x = lerpf(velocity.x, input_dir.x * SPEED, ACCEL * delta)
	velocity.z = lerpf(velocity.z, input_dir.z * SPEED, ACCEL * delta)
	
	var look_dir = Vector2(-velocity.x, velocity.z).angle() + PI/2
	$Mesh.rotation.y = lerp_angle($Mesh.rotation.y, look_dir, ACCEL * delta)
	
	move_and_slide()
