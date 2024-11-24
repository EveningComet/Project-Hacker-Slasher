## The state for when the player is moving on the ground.
class_name PLGround extends PLState

func enter(msgs: Dictionary = {}) -> void:
	match msgs:
		{'velocity': var v}:
			_velocity = v
	
	_skin_handler.animation_tree["parameters/locomotion/playback"].travel("movement")

func exit() -> void:
	_velocity = Vector3.ZERO

func handle_move(delta: float) -> void:
	_apply_movement( delta )
	_apply_friction( delta )
	_cb.set_velocity( _velocity )
	_cb.move_and_slide()
	
	if _cb.is_on_floor() == true and _input_controller.jump_pressed == true:
		my_state_machine.change_to_state("PLAir", {"velocity" = _velocity, "jumping" = true})
		return
	
	if _cb.is_on_floor() == false:
		my_state_machine.change_to_state("PLAir", {"velocity" = _velocity})
		return
	
	orient_to_face_camera_direction(my_state_machine.camera_controller, delta)
	_handle_animations( delta )

func _handle_animations(delta: float) -> void:
	# Modify the input based on the facing direction
	var modified_dir = _velocity * _cb.transform.basis
	_skin_handler.animation_tree.set(
		"parameters/locomotion/movement/blend_position",
		Vector2(modified_dir.x, -modified_dir.z) / move_speed
	)
