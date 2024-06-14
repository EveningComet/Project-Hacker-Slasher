## Stores various formulas.
class_name Formulas

## The base chance to hit.
static var base_hit_chance: float = 90.0

## The base chance for landing a critical hit.
static var base_critical_hit_chance: float = 5.0

## Used for scaling the crit chance.
static var crit_chance_scaler: int = 4

## Displays the chance a character has to hit their target.
## The success chance will be changed based on the skill used.
static func get_chance_to_hit(
	activator: Combatant,
	receiver: Combatant,
	success_chance: float = base_hit_chance
) -> int:
	return floor( success_chance + (activator.get_perception() - receiver.get_evasion()) )

func predict_physical_damage_against(
	attacker: Combatant,
	receiver: Combatant,
	power_scale: float = 1.0
) -> int:
	var attacker_physical_power: int = attacker.get_physical_power()
	var receiver_defense:        int = receiver.get_defense()
	return attacker_physical_power - receiver_defense

func predict_special_damage_against(
	attacker: Combatant,
	receiver: Combatant,
	power_scale: float = 1.0
) -> int:
	var attacker_special_power: int = attacker.get_special_power()
	var receiver_defense:        int = receiver.get_defense()
	return attacker_special_power - receiver_defense

## Get the critical hit chance.
static func get_critical_hit_chance(
	activator: Combatant
) -> int:
	var a = base_critical_hit_chance
	var b = activator.get_crit_chance() / crit_chance_scaler
	return floor( max(base_critical_hit_chance, a + b) )
