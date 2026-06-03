extends CharacterBody2D

const SPEED : float = 100.0
var dir : Vector2

func _physics_process(delta: float) -> void:
	velocity = dir * SPEED
	move_and_slide()
	
func _unhandled_input(event: InputEvent) -> void:
	dir.x = Input.get_axis("ui_left", "ui_right")
	dir.y = Input.get_axis("ui_up", "ui_down")
	dir = dir.normalized()
