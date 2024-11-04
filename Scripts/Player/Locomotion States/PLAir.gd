## State that the player entered from either jumping or falling.
class_name PLAir extends PLState

# Jump & gravity
@export var time_to_jump_apex: float = 0.4 # How long, in seconds, it takes us to reach the height of our jump
@export var max_jump_height:   float = 4   # How high we can jump
@export var min_jump_height:   float = 1   # How low we can jump
var _max_jump_velocity: float = 0
var _min_jump_velocity: float = 0
var gravity:           float = 9.8

func setup_state(new_sm: PlayerLocomotionController) -> void:
	super(new_sm)
	
	# Setup the gravity
	gravity = (2 * max_jump_height) / (time_to_jump_apex * time_to_jump_apex)
	_max_jump_velocity = sqrt(2 * gravity * max_jump_height)
	_min_jump_velocity = sqrt(2 * gravity * min_jump_height)

func enter(msgs: Dictionary = {}) -> void:
	match msgs:
		
		# Entered from a jump
		{'velocity': var v, 'jumping': var mjv}:
			_velocity   = v
			_velocity.y = _max_jump_velocity
			# TODO: Jumping animation.
		
		# Entered from falling
		{'velocity': var v}:
			_velocity = v
	
	#_skin_handler.animation_tree["parameters/locomotion/playback"].travel("falling")

func exit() -> void:
	_velocity = Vector3.ZERO

func handle_move(delta: float) -> void:
	_apply_movement( delta )
	_apply_friction( delta )
	if _input_controller.jump_released == true and _velocity.y > _min_jump_velocity:
		_velocity.y = _min_jump_velocity
	
	_velocity.y -= gravity * delta
	_cb.set_velocity( _velocity )
	_cb.move_and_slide()
	
	if _cb.is_on_ceiling() == true:
		_velocity.y = 0
	
	if _cb.is_on_floor() == true:
		_velocity.y = 0
		my_state_machine.change_to_state("PLGround", {_velocity = _velocity})
		return
	
	orient_to_face_camera_direction(my_state_machine.camera_controller, delta)

func apply_movement(delta: float) -> void:
	if _input_dir != Vector3.ZERO:
		_velocity.x = _velocity.move_toward(_input_dir * move_speed, acceleration * delta).x
		_velocity.z = _velocity.move_toward(_input_dir * move_speed, acceleration * delta).z

func apply_friction(delta: float) -> void:
	if _input_dir == Vector3.ZERO:
		_velocity = _velocity.move_toward(Vector3.ZERO, friction * delta)
