extends TileMap



func _ready() -> void:
	for c in get_used_cells():
		if(get_cell(c.x, c.y) != 2):
			set_cell(c.x, c.y, get_cell_color(c.x, c.y))


func get_cell_color(x: int, y: int) -> int:
	return ( (x + y * 3) % 7) + 3
