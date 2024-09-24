extends Node2D

@export var items : Array[PackedScene]

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	
	var item = rng.randi_range(0, len(items)-1)
	
	var item_instance = items[item].instantiate()
	add_child(item_instance)
	item_instance.position = Vector2(4, 4)
