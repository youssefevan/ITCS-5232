extends Area3D


func _on_body_entered(body):
	if body != get_parent() and body.get_collision_layer_value(3):
		if body.on_fire == false:
			await get_tree().create_timer(0.5).timeout
			if body:
				body.catch_fire()
