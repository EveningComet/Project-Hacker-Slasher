## Visual representation of the player's current skills.
class_name SkillBar extends PanelContainer

## Node that will house the spawned skills.
@export var skill_slot_container: Container

@export var skill_slot_prefab: PackedScene

var player_skills: SkillHandler

## Set the player skills to keep track of and initialize the ui slots.
func set_player_skills(p_skills: SkillHandler) -> void:
	player_skills = p_skills
	
	# Create slots based on the active skills
	for i in Utils.MAX_ACTIVE_SKILLS:
		var skill_slot: SkillSlot = skill_slot_prefab.instantiate()
		skill_slot_container.add_child(skill_slot)
	var index: int = 0
	for slot: SkillSlot in skill_slot_container.get_children():
		var skill: SkillInstance = player_skills.active_skills[index]
		slot.set_skill(skill)
		index += 1
