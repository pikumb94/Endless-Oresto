extends CharacterBody2D

var params: GameParams = preload("res://Game/game_params.tres")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -params.jump_velocity
		
	if Input.is_action_just_released("jump") and velocity.y<0:
		velocity.y = move_toward(velocity.y, 0, params.jump_velocity/3)
		
	move_and_slide()
