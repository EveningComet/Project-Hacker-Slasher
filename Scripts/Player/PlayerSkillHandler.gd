## Modified skill handler component to keep track of the player's skills, and
## allows the player to use their activatable skills.
class_name PlayerSkillHandler extends SkillHandler

@export var camera_controller: CameraController

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("use_skill_slot_1"):
		activate_skill(0)

## Get the aiming direction for the player.
func get_aim_dir() -> Vector3:
	return camera_controller.aim_cast.global_transform * camera_controller.aim_cast.target_position
