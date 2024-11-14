extends Area3D

var rotation_speed = PI/2

func _physics_process(delta):
	rotation.y += rotation_speed * delta


func _on_body_entered(body):
	if body.get_collision_layer_value(2):
		body.collect_powerup()
		
		call_deferred("free")
