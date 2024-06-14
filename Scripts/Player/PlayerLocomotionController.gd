## Responsible for managing movement for the player.
class_name PlayerLocomotionController extends StateMachine

@export var camera_controller: CameraController

## The character body of the attached parent object.
var cb: CharacterBody3D

func set_me_up() -> void:
	cb = get_parent()
	super()

func _physics_process(delta: float) -> void:
	curr_state.physics_update( delta )

func get_cb() -> CharacterBody3D:
	return cb
