## Stores an instance of a skill to allow upgrades.
class_name SkillInstance extends Resource

## The attached skill.
var skill: SkillData

var curr_rank: int = 0:
	get: return curr_rank
	set(value):
		curr_rank = clamp(value, 0, skill.max_rank)

func _init(sd: SkillData) -> void:
	skill = sd
	if skill.is_starting_skill == true:
		curr_rank = 1

func is_max_rank() -> bool:
	return curr_rank == skill.max_rank

func upgrade() -> void:
	curr_rank += 1

func downgrade() -> void:
	curr_rank -= 1
