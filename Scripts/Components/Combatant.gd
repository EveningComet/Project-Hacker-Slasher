## A character that can take damage and die in the game world.
class_name Combatant extends Node

## Fired whenever a stat changes on this character and something needs to
## know about it.
signal stat_changed(com: Combatant)

@export var stats: Stats = Stats.new(self)

func take_damage(damage_data: int) -> void:
	# TODO: Damage data should be more than just an int.
	stats.take_damage(damage_data)
	if OS.is_debug_build() == true:
		var p_name: String = get_parent().name
		print("Combatant :: %s is taking damage." % [p_name])
