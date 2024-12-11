extends Node3D

func _ready():
	$Label3D.visible = false

func _on_radius_body_entered(body):
	if body.get_collision_layer_value(2):
		$Label3D.visible = true
		World.in_shop_radius = true

func _on_radius_body_exited(body):
	if body.get_collision_layer_value(2):
		$Label3D.visible = false
		World.in_shop_radius = false
