extends Node3D

var player_health := 2
var bones := 0
var wave := 0

var enemies_left := 0

var in_shop_radius := false

func reset_variables():
	player_health = 2
	bones = 0
	wave = 0
	enemies_left = 0
	in_shop_radius = false
