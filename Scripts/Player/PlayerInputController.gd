## Responsible for managing the player's input.
class_name PlayerInputController extends Node

var input_dir: Vector3 = Vector3.ZERO

var jump_pressed:  bool = false
var jump_released: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_input_dir()
	
	jump_pressed  = false
	jump_released = false
	if Input.is_action_just_pressed("jump"):
		jump_pressed = true
	if Input.is_action_just_released("jump"):
		jump_released = true

func update_input_dir() -> void:
	input_dir = Vector3.ZERO
	input_dir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_dir.z = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	input_dir = input_dir.normalized() if input_dir.length() > 1 else input_dir
