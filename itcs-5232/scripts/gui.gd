extends Control

@export var player : CharacterBody3D

func _ready() -> void:
	$Pause.visible = false

func _physics_process(delta):
	$HP.text = str("HP: ", World.player_health)
	$Bones.text = str("Bones: ", World.bones)
	$Wave.text = str("Wave: ", World.wave)
	$Zombies.text = str("Enemies: ", World.enemies_left)

func _input(event):
	if Input.is_action_just_pressed("pause"):
		
		$Pause/BG/Stats/Section/Number.text = str(player.speed)
		$Pause/BG/Stats/Section2/Number.text = str(player.fire_rate)
		$Pause/BG/Stats/Section3/Number.text = str(player.ammo_size)
		$Pause/BG/Stats/Section4/Number.text = str(player.fire_round_chance)
		
		$Pause.visible = !$Pause.visible
		get_tree().paused = !get_tree().paused

func _on_resume_pressed():
	$Pause.visible = false
	get_tree().paused = false

func _on_exit_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
