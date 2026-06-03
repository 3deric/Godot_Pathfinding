extends Node2D

var astar_grid : AStarGrid2D = AStarGrid2D.new()
@onready var tile_map : TileMapLayer = $"../TileMapLayer"

func _ready()->void:
	var tile_map_size : Vector2i = tile_map.get_used_rect().end - tile_map.get_used_rect().position
	var map_rect : Rect2i = Rect2i(Vector2i.ZERO, tile_map_size)
	astar_grid.region = map_rect
	var tile_size = tile_map.tile_set.tile_size
	astar_grid.cell_size = tile_size
	astar_grid.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar_grid.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_AT_LEAST_ONE_WALKABLE
	astar_grid.update()
	
	for i in tile_map_size.x:
		for j in tile_map_size.y:
			var coords = Vector2i(i, j)
			var tile_data = tile_map.get_cell_tile_data(coords)
			if tile_data and tile_data.get_custom_data('wall') == true:
				astar_grid.set_point_solid(coords)

func is_point_movable(position : Vector2i) -> bool:
	var map_position = tile_map.local_to_map(position)
	if astar_grid.is_in_boundsv(map_position) and not astar_grid.is_point_solid(map_position):
		return true
	return false
	
func get_movement_path(from : Vector2i, to: Vector2i) -> Array[Vector2i]:
	return astar_grid.get_id_path(from,to).slice(1)
