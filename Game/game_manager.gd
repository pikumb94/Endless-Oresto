extends Node

const SAVE_PATH := "user://save.cfg"

var params: GameParams = preload("res://Game/game_params.tres")

## Obstacles picked at random; add the same scene more times to make it more frequent.
@export var obstacle_scenes: Array[PackedScene] = []

@onready var camera: Camera2D = $"../Camera"
@onready var player: CharacterBody2D = $"../Player"
@onready var obstacles: Node2D = $"../Obstacles"
@onready var hud: Hud = $"../HUD/Hud"

var speed: float
var distance := 0.0
var score := 0
var high_score := 0
var is_game_over := false
var game_over_time := 0.0
var next_spawn_x: float


func _ready() -> void:
	# Keeps listening for the restart input while the tree is paused.
	process_mode = Node.PROCESS_MODE_ALWAYS
	speed = params.speed
	high_score = _load_high_score()
	next_spawn_x = _screen_right() + params.first_obstacle_distance
	hud.update_score(score, high_score)


func _physics_process(delta: float) -> void:
	if is_game_over:
		return

	speed = minf(speed + params.acceleration * delta, params.max_speed)

#apply movement to right to both camera and player
	camera.move_local_x(speed*delta)
	player.velocity.x = speed

	distance += speed * delta
	var new_score := int(distance * params.score_per_pixel)
	if new_score != score:
		score = new_score
		hud.update_score(score, high_score)

	_spawn_obstacles()


func _process(_delta: float) -> void:
	if is_game_over and Input.is_action_just_pressed("jump") \
			and _now() - game_over_time >= params.restart_delay:
		get_tree().paused = false
		get_tree().reload_current_scene()


func _spawn_obstacles() -> void:
	if obstacle_scenes.is_empty():
		return
	while next_spawn_x < _screen_right() + params.spawn_margin:
		var obstacle: Obstacle = obstacle_scenes.pick_random().instantiate()
		obstacle.position = Vector2(next_spawn_x, params.ground_y)
		obstacle.hit.connect(_on_obstacle_hit)
		obstacles.add_child(obstacle)
		# Faster runs need more room to land between obstacles.
		next_spawn_x += randf_range(params.gap_min, params.gap_max) * speed / maxf(params.speed, 1.0)


func _on_obstacle_hit() -> void:
	if is_game_over:
		return
	is_game_over = true
	game_over_time = _now()
	if score > high_score:
		high_score = score
		_save_high_score()
	hud.update_score(score, high_score)
	hud.show_game_over()
	get_tree().paused = true


func _screen_right() -> float:
	return camera.global_position.x + camera.get_viewport_rect().size.x / 2.0 / camera.zoom.x


func _now() -> float:
	return Time.get_ticks_msec() / 1000.0


func _load_high_score() -> int:
	var cfg := ConfigFile.new()
	if cfg.load(SAVE_PATH) != OK:
		return 0
	return cfg.get_value("score", "high", 0)


func _save_high_score() -> void:
	var cfg := ConfigFile.new()
	cfg.set_value("score", "high", high_score)
	cfg.save(SAVE_PATH)
