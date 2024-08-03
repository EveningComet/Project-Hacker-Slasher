## Stores the skills for a character.
class_name SkillHandler extends Node

## The skills the player currently has on their character.
@export var curr_skills: Array[SkillInstance] = []

## The skills in the player's current activatable skills.
@export var active_skills: Array[SkillInstance] = []

func _physics_process(delta: float) -> void:
	# TODO: Go through the skills and tick through the cooldowns.
	pass

func update_active_skills(delta: float) -> void:
	for s in active_skills:
		s.tick(delta)

func activate_skill() -> void:
	pass
