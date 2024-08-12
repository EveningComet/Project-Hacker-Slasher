## Skill for spawning auras/aoes.
class_name SpawnAura extends SkillEffect

## The aura this skill should spawn.
@export var aura_to_spawn: PackedScene

## Spawn the aura and have it attach to the activator.
func execute(activator, targets) -> void:
	var combatant: Combatant = activator.get_node("Combatant")
	var aura = aura_to_spawn.instantiate()
	
	# TODO: Have the healing power based on a stat.
	var healing_power: int = get_power(activator)
	activator.add_child(aura)
	
