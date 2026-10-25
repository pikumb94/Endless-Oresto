class_name GameParams
extends Resource

@export_group("Player Movement")

## Starting horizontal speed (px/s).
@export_range(0.0, 1000.0, 0.1, "or_greater", "hide_slider")
var speed: float = 300.0

@export_range(0.0, 1000.0, 0.1, "or_greater", "hide_slider")
var jump_velocity: float = 350.0

@export_group("Difficulty")

## Speed gained every second (px/s²).
@export_range(0.0, 100.0, 0.1, "or_greater", "hide_slider")
var acceleration: float = 6.0

## Speed cap (px/s).
@export_range(0.0, 2000.0, 0.1, "or_greater", "hide_slider")
var max_speed: float = 650.0

@export_group("Obstacles")

## World Y where obstacles stand (the horizon line of the ground sprite).
@export var ground_y: float = 301.0

## Distance from the right screen edge of the first obstacle.
@export_range(0.0, 2000.0, 1.0, "or_greater", "hide_slider")
var first_obstacle_distance: float = 300.0

## Gap between two obstacles at starting speed; it grows proportionally with speed.
@export_range(0.0, 2000.0, 1.0, "or_greater", "hide_slider")
var gap_min: float = 260.0

@export_range(0.0, 2000.0, 1.0, "or_greater", "hide_slider")
var gap_max: float = 650.0

## How far beyond the right screen edge obstacles are spawned.
@export_range(0.0, 500.0, 1.0, "or_greater", "hide_slider")
var spawn_margin: float = 64.0

@export_group("Turtle")

@export_range(0.0, 1000.0, 0.1, "or_greater", "hide_slider")
var turtle_hop_velocity: float = 250.0

## Random wait between two hops (seconds).
@export_range(0.0, 10.0, 0.01, "or_greater", "hide_slider")
var turtle_hop_interval_min: float = 0.8

@export_range(0.0, 10.0, 0.01, "or_greater", "hide_slider")
var turtle_hop_interval_max: float = 2.5

@export_group("Score")

## Points earned per pixel travelled.
@export_range(0.0, 1.0, 0.001, "or_greater", "hide_slider")
var score_per_pixel: float = 0.04

## Seconds after game over before jump restarts the run.
@export_range(0.0, 5.0, 0.01, "or_greater", "hide_slider")
var restart_delay: float = 0.5

## Score multiple that plays the "point" jingle (0 disables it).
@export_range(0, 10000, 1, "or_greater", "hide_slider")
var milestone_points: int = 100

@export_group("Audio")

@export_range(-40.0, 12.0, 0.1)
var sfx_volume_db: float = -6.0

## Extra volume of the turtle hop, so it doesn't cover the player's sounds.
@export_range(-40.0, 12.0, 0.1)
var turtle_hop_volume_db: float = -8.0
