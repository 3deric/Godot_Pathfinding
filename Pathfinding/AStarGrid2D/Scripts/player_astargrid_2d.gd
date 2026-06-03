extends CharacterBody2D

const SPEED = 2.0

@onready var tile_map : TileMapLayer = $"../TileMapLayer"
@onready var astar : Node2D = $"../AStarGrid2D"
var current_path : Array[Vector2i]

func _physics_process(delta: float) -> void:
	if current_path.is_empty():
		return
	var target_position = tile_map.map_to_local(current_path.front())
	global_position = global_position.move_toward(target_position, SPEED)
	if global_position == target_position:
		current_path.pop_front()

func _unhandled_input(event: InputEvent) -> void:
	var click_position = get_global_mouse_position()
	if event.is_action_pressed("move_to"):
		if astar.is_point_movable(click_position):
			current_path = astar.get_movement_path(
				tile_map.local_to_map(global_position),
				tile_map.local_to_map(click_position)
			)		
			print(current_path)
