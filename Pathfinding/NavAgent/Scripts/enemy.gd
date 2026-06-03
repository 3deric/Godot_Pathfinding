extends CharacterBody2D

const SPEED : float = 80.0

@export var player : Node2D
@onready var nav_agent : NavigationAgent2D = $NavigationAgent2D

func _physics_process(delta: float) -> void:
	var dir : Vector2 = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * SPEED
	move_and_slide()
	
func _make_path() -> void:
	nav_agent.target_position = player.global_position

func _on_timer_timeout() -> void:
	_make_path()
