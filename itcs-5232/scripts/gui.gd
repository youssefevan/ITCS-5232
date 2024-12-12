extends Control

func _ready() -> void:
	$Pause.visible = false

func _physics_process(delta):
	$HP.text = str("HP: ", World.player_health)
	$Bones.text = str("Bones: ", World.bones)
	$Wave.text = str("Wave: ", World.wave)
	$Zombies.text = str("Enemies: ", World.enemies_left)

func _input(event):
	if Input.is_action_just_pressed("pause"):
		$Pause.visible = !$Pause.visible
		get_tree().paused = !get_tree().paused
