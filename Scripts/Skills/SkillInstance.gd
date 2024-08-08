## Stores an instance of a skill to allow upgrades.
class_name SkillInstance extends Resource

## Used to tell other things that the attached skill is being used.
signal skill_executed(si: SkillInstance)

## The attached skill.
@export var skill: SkillData

var curr_cooldown: float = 0.0:
	get: return curr_cooldown
	set(value):
		curr_cooldown = value
		curr_cooldown = clamp(curr_cooldown, 0.0, skill.base_cooldown)

func tick(delta: float) -> void:
	curr_cooldown -= delta

func reset_cooldown() -> void:
	curr_cooldown = skill.base_cooldown

func is_cooldown_finished() -> bool:
	return curr_cooldown <= 0.0

## Quick way to execute the attached skill.
func execute(activator, targets) -> void:
	skill_executed.emit(self)
	skill.execute(activator, targets)
