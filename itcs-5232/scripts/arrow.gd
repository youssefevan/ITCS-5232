extends Area3D

var speed = 30

var on_fire := false

var size := 1.0

@onready var arrow_mesh_scene = preload("res://models/arrow.glb")

func _ready():
	$Mesh.scale = Vector3(size, size, size)
	$Collider.scale = Vector3(size, size, size)
	$VisibleOnScreenNotifier3D.scale = Vector3(size, size, size)
	
	if on_fire:
		$Mesh.material.emission_enabled = true
	else:
		$Mesh.material.emission_enabled = false
	await get_tree().create_timer(1.5).timeout
	call_deferred("queue_free") 

func _physics_process(delta) -> void:
	position += transform.basis * Vector3(speed, 0, 0) * delta

func _on_body_entered(body):
	if body.get_collision_layer_value(1):
		call_deferred("queue_free")
	
	elif body.get_collision_layer_value(3):
		body.get_hit(on_fire)
		call_deferred("queue_free")

func disable_collision():
	$Collider.disabled = true

func _on_visible_on_screen_notifier_3d_screen_exited():
	call_deferred("queue_free")
