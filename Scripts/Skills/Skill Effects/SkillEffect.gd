## Defines what a skill does.
class_name SkillEffect extends Resource

## The output of this skill.
@export var power_scale: float = 1.0

func execute(activator, targets) -> void:
	pass

func get_power(user) -> int:
	return 1

func get_physical_power(user) -> int:
	return 1

func get_special_power(user) -> int:
	return 1
