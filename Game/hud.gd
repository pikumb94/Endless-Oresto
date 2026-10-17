class_name Hud
extends Node2D
## Score and game over text drawn with a tiny 3x5 pixel font, to match the spritesheet.

const GLYPHS := {
	"0": ["###", "#.#", "#.#", "#.#", "###"],
	"1": [".#.", "##.", ".#.", ".#.", "###"],
	"2": ["###", "..#", "###", "#..", "###"],
	"3": ["###", "..#", "###", "..#", "###"],
	"4": ["#.#", "#.#", "###", "..#", "..#"],
	"5": ["###", "#..", "###", "..#", "###"],
	"6": ["###", "#..", "###", "#.#", "###"],
	"7": ["###", "..#", "..#", "..#", "..#"],
	"8": ["###", "#.#", "###", "#.#", "###"],
	"9": ["###", "#.#", "###", "..#", "###"],
	"A": ["###", "#.#", "###", "#.#", "#.#"],
	"E": ["###", "#..", "##.", "#..", "###"],
	"G": ["###", "#..", "#.#", "#.#", "###"],
	"H": ["#.#", "#.#", "###", "#.#", "#.#"],
	"I": ["###", ".#.", ".#.", ".#.", "###"],
	"M": ["#.#", "###", "###", "#.#", "#.#"],
	"O": ["###", "#.#", "#.#", "#.#", "###"],
	"R": ["##.", "#.#", "##.", "#.#", "#.#"],
	"V": ["#.#", "#.#", "#.#", "#.#", ".#."],
}
const GLYPH_WIDTH := 3
const GLYPH_HEIGHT := 5

@export var color := Color8(61, 61, 61)
@export var high_score_color := Color8(140, 140, 140)
@export var score_pixel_size := 2
@export var game_over_pixel_size := 3
@export var screen_margin := 6.0

var score := 0
var high_score := 0
var game_over := false


func update_score(new_score: int, new_high_score: int) -> void:
	score = new_score
	high_score = new_high_score
	queue_redraw()


func show_game_over() -> void:
	game_over = true
	queue_redraw()


func _draw() -> void:
	var screen := get_viewport_rect().size
	var current := "%05d" % score
	var x := screen.x - screen_margin - _text_width(current, score_pixel_size)
	_draw_text(current, Vector2(x, screen_margin), score_pixel_size, color)

	if high_score > 0:
		var best := "HI %05d  " % high_score
		x -= _text_width(best, score_pixel_size) + score_pixel_size
		_draw_text(best, Vector2(x, screen_margin), score_pixel_size, high_score_color)

	if game_over:
		var text := "GAME OVER"
		var pos := Vector2(screen.x - _text_width(text, game_over_pixel_size), screen.y - GLYPH_HEIGHT * game_over_pixel_size) / 2.0
		_draw_text(text, pos.round(), game_over_pixel_size, color)


func _text_width(text: String, pixel: int) -> float:
	return text.length() * (GLYPH_WIDTH + 1) * pixel - pixel


func _draw_text(text: String, pos: Vector2, pixel: int, col: Color) -> void:
	for i in text.length():
		var rows: Array = GLYPHS.get(text[i], [])
		var origin := pos + Vector2(i * (GLYPH_WIDTH + 1) * pixel, 0)
		for row in rows.size():
			for column in GLYPH_WIDTH:
				if rows[row][column] == "#":
					draw_rect(Rect2(origin + Vector2(column, row) * pixel, Vector2(pixel, pixel)), col)
