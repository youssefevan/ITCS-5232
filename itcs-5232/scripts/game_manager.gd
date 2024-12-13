extends Node3D

var spawners = []

func _ready():
	World.reset_variables()
	for spawner in get_tree().get_nodes_in_group("Spawner"):
		spawners.append(spawner)

func new_wave():
	World.wave += 1
	World.enemies_left = 0
	for spawner in spawners:
		spawner.start_wave = false
		if spawner.unlock_wave <= World.wave:
			spawner.spawn_amount = ceil(pow(3*World.wave, 0.75))
			World.enemies_left += spawner.spawn_amount
	
	await get_tree().create_timer(5).timeout
	
	for spawner in spawners:
		spawner.start_wave = true

func _physics_process(delta):
	if World.enemies_left <= 0:
		new_wave()

func player_died():
	$"../GUI/Pause".visible = true
