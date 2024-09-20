extends Node2D

enum whose_turn {PLAYER, ENEMY}

var active_entities = []

@export var player : Player

func start_turn() -> void:
	pass

func end_turn() -> void:
	active_entities = []
