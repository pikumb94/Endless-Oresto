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
