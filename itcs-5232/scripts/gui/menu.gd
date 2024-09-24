extends Control


@onready var inventory = $ScrollContainer/Inventory

var inventory_mode := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	pass

func _on_player_inventory_mode(mode):
	inventory_mode = mode
	
	if inventory_mode:
		$ScrollContainer/Inventory/Button.grab_focus()
	else:
		get_viewport().gui_get_focus_owner().release_focus()
