extends Obstacle

var params: GameParams = preload("res://Game/game_params.tres")

var hop_gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var ground_y: float
var velocity_y := 0.0
var hop_timer := 0.0


func _ready() -> void:
	super()
	ground_y = position.y
	_reset_hop_timer()


func _physics_process(delta: float) -> void:
	super(delta)

	var on_ground := position.y >= ground_y and velocity_y >= 0.0
	if on_ground:
		hop_timer -= delta
		if hop_timer <= 0.0:
			velocity_y = -params.turtle_hop_velocity
			_reset_hop_timer()
	else:
		velocity_y += hop_gravity * delta

	position.y += velocity_y * delta
	if position.y >= ground_y:
		position.y = ground_y
		velocity_y = 0.0


func _reset_hop_timer() -> void:
	hop_timer = randf_range(params.turtle_hop_interval_min, params.turtle_hop_interval_max)
