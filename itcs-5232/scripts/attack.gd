extends Area2D
class_name Attack

var damage : int
enum type {FIRE, ICE, MAGIC, NECROTIC}

@export var color : Color

func _ready():
	$Sprite.material.set("shader_parameter/inputColor", color)
	$Sprite.material.set("shader_parameter/transparentBG", true)
