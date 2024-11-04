## Responsible for managing movement for the player.
class_name PlayerLocomotionController extends StateMachine

@export var input_controller:  PlayerInputController
@export var camera_controller: CameraController
@onready var skin_handler: SkinHandler = get_parent().get_node("SkinHandler")

## The character body of the attached parent object.
@onready var cb: CharacterBody3D = get_parent()

func set_me_up() -> void:
	super()

func _physics_process(delta: float) -> void:
	curr_state.physics_update( delta )

func get_cb() -> CharacterBody3D:
	return cb
