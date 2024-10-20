extends Area2D
class_name Enemy

@export var speed : float
@export var max_health : int

@export var animation_speed := 5.0

var moving := false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)
	set_process(false)

func movement_tween(dir):
	var tween = create_tween()
	tween.tween_property(self, "position", dir, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
	moving = true
	await tween.finished
	moving = false

func _on_area_entered(area):
	if area.get_collision_layer_value(7):
		pass

func _on_visible_on_screen_notifier_2d_screen_entered():
	set_physics_process(true)
	set_process(true)

func _on_visible_on_screen_notifier_2d_screen_exited():
	set_physics_process(false)
	set_process(false)
