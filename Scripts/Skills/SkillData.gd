## Stores associated information for a skill.
class_name SkillData extends Resource

@export_category("Base Info")
@export var localization_name:                  String = "New Skill"
@export_multiline var localization_description: String = "New description."

@export var display_icon: Texture2D

@export_category("Definitions")
## Can this skill be activated?
@export var is_passive: bool = false

## How long, in seconds, before this skill can be used again?
@export var base_cooldown: float = 2.0

## The base special cost to use this skill.
@export var base_cost: int = 5

## The collection of effects that define what a skill does.
@export var effects: Array[SkillEffect] = []

@export_category("Unlock Info")
## Is a character able to use this skill at the start?
@export var is_starting_skill: bool = false

func execute(user, targets) -> void:
	for e: SkillEffect in effects:
		e.execute(user, targets)
