extends Control

func _physics_process(delta):
	$HP.text = str("HP: ", World.player_health)
	$Bones.text = str("Bones: ", World.bones)
	$Wave.text = str("Wave: ", World.wave)
	$Zombies.text = str("Enemies: ", World.enemies_left)
