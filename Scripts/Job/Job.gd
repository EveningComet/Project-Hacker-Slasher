@tool
## Defines a set of data related to a class that a player character can be.
class_name Job extends Resource

@export_category("Base Info")
@export var           localization_name:        String = "New Job"
@export_multiline var localization_description: String = "New description."

@export_category("Stats")
@export var starting_strength: int = 25

@export_category("Skill Data")
## Allows for a quick way to update the skills used by this job.
@export var file_path_to_job_skills: String

## Forces the system to update the stored skills.
@export var update_attached_skills: bool:
	set(value):
		read_skills()

## The skills that are associated with this job.
@export var skills: Array[SkillData] = []

## Read the skill data objects at the stored directory and add them to the skills
## this job can use.
func read_skills() -> void:
	skills.clear()
	var dir = DirAccess.open( file_path_to_job_skills )
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name.is_empty() == false:
			if file_name.ends_with(".tres") == true:
				var found_skill: SkillData = load(
					file_path_to_job_skills + "/" + file_name
				)
				skills.append( found_skill )
			file_name = dir.get_next()
		dir.list_dir_end()
