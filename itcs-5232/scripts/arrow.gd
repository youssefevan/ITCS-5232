extends Area3D

var speed = 25
var rotatation_speed = 15

@onready var arrow_mesh_scene = preload("res://models/arrow.glb")

func _ready():
	await get_tree().create_timer(5).timeout
	call_deferred("queue_free") 

func _process(delta):
	$arrow.rotation.x += rotatation_speed * delta
	position += transform.basis * Vector3(speed, 0, 0) * delta

func _on_body_entered(body):
	if body.get_collision_layer_value(1):
		speed = 0
		rotatation_speed = 0
		call_deferred("disable_collision")
	
	elif body.get_collision_layer_value(3):
		body.health -= 1
		call_deferred("queue_free")

func disable_collision():
	$Collider.disabled = true

func _on_visible_on_screen_notifier_3d_screen_exited():
	call_deferred("queue_free")
