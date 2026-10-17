class_name DecorationLayer
extends Parallax2D
## Parallax layer that keeps scattering random sprites ahead of the screen
## and frees the ones left behind. Leave repeat_size at 0.

@export var textures: Array[Texture2D] = []

## Random empty space between two decorations (layer pixels).
@export var gap_min: float = 60.0
@export var gap_max: float = 220.0

## Random world Y of the decoration's bottom edge.
@export var bottom_y_min: float = 301.0
@export var bottom_y_max: float = 301.0

@export var margin: float = 64.0

var _next_x := NAN


func _process(_delta: float) -> void:
	if textures.is_empty():
		return

	# Screen edges expressed in this layer's local coordinates.
	var screen_width := get_viewport_rect().size.x
	var to_local_space := get_global_transform_with_canvas().affine_inverse()
	var left := (to_local_space * Vector2.ZERO).x
	var right := (to_local_space * Vector2(screen_width, 0.0)).x

	if is_nan(_next_x):
		_next_x = left - screen_width + randf_range(0.0, gap_max)

	while _next_x < right + margin:
		_next_x += _spawn(_next_x) + randf_range(gap_min, gap_max)

	for child in get_children():
		var sprite := child as Sprite2D
		if sprite and sprite.position.x + sprite.texture.get_width() < left - margin:
			sprite.queue_free()


## Returns the width of the spawned sprite.
func _spawn(x: float) -> float:
	var sprite := Sprite2D.new()
	sprite.texture = textures.pick_random()
	sprite.centered = false
	sprite.offset = Vector2(0.0, -sprite.texture.get_height())
	sprite.position = Vector2(x, randf_range(bottom_y_min, bottom_y_max)).round()
	add_child(sprite)
	return sprite.texture.get_width()
