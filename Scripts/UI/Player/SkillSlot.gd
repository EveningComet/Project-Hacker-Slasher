## A visual representation of a skill that the player can use.
class_name SkillSlot extends PanelContainer

@export var icon: TextureRect

var skill: SkillInstance

func set_skill(new_skill: SkillInstance) -> void:
	skill = new_skill
	icon.set_texture(skill.skill.display_icon)
