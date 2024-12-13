extends Node3D

@export var price : int
@export var type : String
@export var display_name : String
@export var modifier : String

var in_range := false

var player

func _ready():
	$Label3D.visible = false
	$Label3D.text = str(
		display_name, " ", modifier,"\n", price, " bones"
	)

func _on_radius_body_entered(body):
	if body.get_collision_layer_value(2):
		player = body
		
		$Label3D.visible = true
		in_range = true

func _on_radius_body_exited(body):
	if body.get_collision_layer_value(2):
		$Label3D.visible = false
		in_range = false
		
func _input(event):
	if Input.is_action_just_pressed("buy"):
		if in_range and World.bones >= price and player:
			buy()

func buy():
	$BuySFX.play()
	
	player.collect_powerup(type)
	World.bones -= price
	$AnimationPlayer.stop(false)
	$AnimationPlayer.play("buy")
	
	price = int(price * 1.5)
	$Label3D.text = str(
		display_name, " ", modifier,"\n", price, " bones"
	)

func _physics_process(delta):
	if World.bones >= price:
		$Label3D.modulate = Color.GREEN
	else:
		$Label3D.modulate = Color.RED
