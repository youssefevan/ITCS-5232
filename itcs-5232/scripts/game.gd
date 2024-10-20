extends Node2D

enum whose_turn {PLAYER, ENEMY}

var active_entities = []

@export var player : Player
@export var camera : Camera2D

var rng = RandomNumberGenerator.new()

var directions = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]

func _ready():
	rng.randomize()

func start_turn() -> void:
	pass

func end_turn() -> void:
	active_entities = []
