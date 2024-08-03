## Manages displaying a player's hp and sp.
class_name PlayerHUD extends CanvasLayer

## The player currently being monitored by this HUD.
@export var curr_player: PlayerCharacter

@export var skill_bar: SkillBar

@export_category("Vitals")
# HP & SP bars
@export var hp_bar: ProgressBar
@export var sp_bar: ProgressBar

# Ammo counter

func _ready() -> void:
	if curr_player != null:
		setup_for_player(curr_player)

func setup_for_player(new_player: PlayerCharacter) -> void:
	curr_player = new_player
	skill_bar.set_player_skills(curr_player.skill_handler)
	
	var combatant: Combatant = curr_player.combatant
	combatant.stat_changed.connect( on_stat_changed )
	on_stat_changed(combatant)

func on_stat_changed(com: Combatant) -> void:
	# Update the vitals based on damage, skill use, etc.
	hp_bar.value = (float(com.stats.get_curr_hp()) / com.stats.get_max_hp()) * 100
	sp_bar.value = (float(com.stats.get_curr_sp()) / com.stats.get_max_sp()) * 100
