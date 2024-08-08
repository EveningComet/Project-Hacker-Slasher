## A visual representation of a skill that the player can use.
class_name SkillSlot extends PanelContainer

## Displays the skill's icon to the player.
@export var icon: TextureRect

## Cooldown sweep.
@export var progress_bar: TextureProgressBar

## Cooldown value displayer.
@export var time_label: Label

var skill: SkillInstance

func _ready() -> void:
	set_physics_process(false)
	progress_bar.value = 0
	time_label.hide()

func set_skill(new_skill: SkillInstance) -> void:
	if skill != null:
		skill.skill_executed.disconnect( on_skill_executed )
	
	skill = new_skill
	if skill != null:
		icon.set_texture(skill.skill.display_icon)
		skill.skill_executed.connect( on_skill_executed )
	
	time_label.hide()
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	var cooldown: float = skill.curr_cooldown
	progress_bar.value = int((cooldown / skill.skill.base_cooldown) * 100)
	time_label.set_text( "%3.1f" % skill.curr_cooldown )
	
	# Cooldown finished, turn off relevant displays
	if cooldown <= 0.0:
		time_label.hide()
		set_physics_process(false)

## Have the UI update properly once the attached skill has been fired.
func on_skill_executed(_s: SkillInstance) -> void:
	time_label.show()
	set_physics_process(true)
