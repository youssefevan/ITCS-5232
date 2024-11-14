extends Control

func _physics_process(delta):
	$HP.text = str("HP: ", World.player_health)
	$Bones.text = str("Bones: ", World.bones)
