## Defines a state on how the player should move.
class_name PLState extends State

## Every state needs to check for movement in some way.
var _cb: CharacterBody3D

# Air, Speed, & Friction
@export var move_speed:      float = 10   # How fast this state moves
@export var acceleration:    float = 60.0
@export var friction:        float = 50.0
@export var rot_speed:       float = 10.0 # How fast we rotate

# Every state needs to keep track of their movement vector and input
var _velocity:  Vector3 = Vector3.ZERO
var _input_dir: Vector3 = Vector3.ZERO

var _skin_handler: SkinHandler

var _input_controller: PlayerInputController

func setup_state(new_sm: PlayerLocomotionController) -> void:
	super(new_sm)
	_cb               = new_sm.cb
	_input_controller = new_sm.input_controller
	_skin_handler     = new_sm.skin_handler

func _handle_animations(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	_get_input_vector()
	handle_move( delta )

func _get_input_vector() -> void:
	# Get our movement value, adjusted to work with controllers
	_input_dir = Vector3.ZERO
	_input_dir.x = _input_controller.input_dir.x
	_input_dir.z = _input_controller.input_dir.z
	
	# Adjust the input based on where we're looking
	_input_dir = (_input_dir.x * _cb.transform.basis.x) + (_input_dir.z * _cb.transform.basis.z)

func handle_move(delta: float) -> void:
	pass

func _apply_movement(delta: float) -> void:
	if _input_dir != Vector3.ZERO:
		_velocity.x = _velocity.move_toward(_input_dir * move_speed, acceleration * delta).x
		_velocity.z = _velocity.move_toward(_input_dir * move_speed, acceleration * delta).z

func _apply_friction(delta: float) -> void:
	if _input_dir == Vector3.ZERO:
		_velocity.x = _velocity.move_toward(Vector3.ZERO, friction * delta).x
		_velocity.z = _velocity.move_toward(Vector3.ZERO, friction * delta).z
	
## Many of the movement states need to update the character's facing direction
## based on the camera.
func orient_to_face_camera_direction(camera: CameraController, delta: float) -> void:
	var direction = (camera.global_transform.basis * Vector3.BACK).normalized()
	var q_from = _cb.transform.basis.get_rotation_quaternion()
	var left_axis = Vector3.UP.cross(direction)
	var rotation_basis = Basis(left_axis, Vector3.UP, direction).get_rotation_quaternion()
	_cb.basis = Basis(q_from.slerp(rotation_basis, delta * rot_speed))
	
	# Prevent weird stuff from happening
	_cb.transform.basis = _cb.transform.basis.orthonormalized()
