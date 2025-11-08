extends Node

var params: GameParams = preload("res://Game/game_params.tres")
@onready var camera: Camera2D = $"../Camera"
@onready var player: CharacterBody2D = $"../Player"

func _physics_process(delta: float) -> void:

#apply movement to right to both camera and player
	camera.move_local_x(params.speed*delta)
	player.velocity.x =  params.speed
	return
