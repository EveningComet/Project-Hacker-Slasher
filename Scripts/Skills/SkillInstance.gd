## Stores an instance of a skill to allow upgrades.
class_name SkillInstance extends Resource

## The attached skill.
@export var skill: SkillData

var curr_cooldown: float = 0.0:
	get: return curr_cooldown
	set(value):
		curr_cooldown = value
		curr_cooldown = clamp(curr_cooldown, 0.0, skill.base_cooldown)

func _init(sd: SkillData) -> void:
	skill = sd

func tick(delta: float) -> void:
	curr_cooldown -= delta

func is_cooldown_finished() -> bool:
	return curr_cooldown <= 0.0
