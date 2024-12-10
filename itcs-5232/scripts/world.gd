extends Node3D

var player_health := 10
var bones := 0
var wave := 0

var spawners = []
var enemies_left := 0

func _ready():
	for spawner in get_tree().get_nodes_in_group("Spawner"):
		spawners.append(spawner)

func new_wave():
	wave += 1
	for spawner in spawners:
		spawner.start_wave = false
		if spawner.unlock_wave <= wave:
			spawner.spawn_amount = ceil(pow(3*wave, 0.75))
			enemies_left += spawner.spawn_amount
	
	await get_tree().create_timer(5).timeout
	for spawner in spawners:
		spawner.start_wave = true

func _physics_process(delta):
	if enemies_left == 0:
		new_wave()
