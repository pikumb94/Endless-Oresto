class_name Obstacle
extends Area2D

## Emitted when the player's hurtbox touches the obstacle (it is the only layer in the mask).
signal hit


func _ready() -> void:
	area_entered.connect(func(_area: Area2D) -> void: hit.emit())


func _physics_process(_delta: float) -> void:
	# Free once it is a full screen behind the camera.
	var cam := get_viewport().get_camera_2d()
	if cam and global_position.x < cam.global_position.x - get_viewport_rect().size.x:
		queue_free()
