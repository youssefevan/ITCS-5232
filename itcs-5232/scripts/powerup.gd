extends Area3D

var rotation_speed = PI/2

@export var type := "mushroom"

func _ready():
	$temp.visible = false

func _physics_process(delta):
	rotation.y += rotation_speed * delta

func _on_body_entered(body):
	if body.get_collision_layer_value(2):
		body.collect_powerup(type)
		
		call_deferred("free")
