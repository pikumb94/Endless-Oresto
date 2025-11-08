class_name GameParams
extends Resource

@export_group("Player Movement")

@export_range(0.0, 1000.0, 0.1, "or_greater", "hide_slider")
var speed: float = 300.0

@export_range(0.0, 1000.0, 0.1, "or_greater", "hide_slider")
var jump_velocity: float = 400.0
