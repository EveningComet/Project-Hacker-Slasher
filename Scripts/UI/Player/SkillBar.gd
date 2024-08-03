## Visual representation of the player's current skills.
class_name SkillBar extends PanelContainer



## Node that will house the spawned skills.
@export var skill_slot_container: Container

@export var skill_slot_prefab: PackedScene

var player_skills: SkillHandler

## Set the player skills to keep track of and initialize the ui slots.
func set_player_skills(p_skills: SkillHandler) -> void:
	player_skills = p_skills
	
	for i in Utils.MAX_ACTIVE_SKILLS:
		var skill_slot: SkillSlot = skill_slot_prefab.instantiate()
		skill_slot_container.add_child(skill_slot)
