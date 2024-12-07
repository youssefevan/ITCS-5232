extends Node3D

@export var speed := 5.0

func _physics_process(delta):
	rotation.y += speed * delta
