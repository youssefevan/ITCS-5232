extends Area3D

var speed = 25
var rotatation_speed = 15

func _ready():
	await get_tree().create_timer(5).timeout
	call_deferred("queue_free")

func _physics_process(delta):
	rotation.x += rotatation_speed * delta
	position += transform.basis * Vector3(speed, 0, 0) * delta

func _on_body_entered(body):
	speed = 0
	rotatation_speed = 0

func _on_visible_on_screen_notifier_3d_screen_exited():
	call_deferred("queue_free")
