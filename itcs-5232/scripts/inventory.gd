extends Control

func _ready():
	visible = false

func _input(event):
	if Input.is_action_just_pressed("inventory") and World.in_shop_radius:
		visible = !visible
		get_tree().paused = !get_tree().paused
