## Stores an instance of a skill to allow upgrades.
class_name SkillInstance extends Resource

## The attached skill.
var skill: SkillData

func _init(sd: SkillData) -> void:
	skill = sd
