## Stores the skills for a character.
class_name SkillHandler extends Node

## The skills the player currently has on their character.
@export var curr_skills: Array[SkillInstance] = []

## The skills in the player's current activatable skills.
@export var active_skills: Array[SkillInstance] = []

## Used as a quick way to get a character's stats.
@export var combatant: Combatant

func _ready() -> void:
	# Create empty slots to allow for swapping and the like
	print(active_skills)
	var copy_of_active_skills: Array[SkillInstance] = []
	copy_of_active_skills.append_array(active_skills)
	print(copy_of_active_skills)
	active_skills.clear()
	for i in Utils.MAX_ACTIVE_SKILLS:
		active_skills.append( null )
	for i in range(copy_of_active_skills.size()):
		active_skills.insert(i, copy_of_active_skills[i])
	
	print(active_skills)

func _physics_process(delta: float) -> void:
	update_active_skills( delta )

func update_active_skills(delta: float) -> void:
	for s in active_skills:
		if s != null:
			s.tick(delta)

## Attempt to activate a usable skill.
func activate_skill(index: int) -> void:
	var skill_instance: SkillInstance = active_skills[index]
	if skill_instance != null:
		_was_skill_use_successful(skill_instance)

## Determines if the skill use was successful.
func _was_skill_use_successful(skill_instance: SkillInstance) -> bool:
	var curr_sp: int = combatant.stats.get_curr_sp()
	if curr_sp >= skill_instance.skill.base_cost and skill_instance.is_cooldown_finished() == true:
		skill_instance.execute(
			get_parent(), []
		)
		skill_instance.reset_cooldown()
		
		return true
	
	return false
