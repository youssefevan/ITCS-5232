extends Node2D

@export var enemies : Array[PackedScene]

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	
	var enemy = rng.randi_range(0, len(enemies)-1)
	
	var enemy_instance = enemies[enemy].instantiate()
	add_child(enemy_instance)
	enemy_instance.position = Vector2(4, 4)
