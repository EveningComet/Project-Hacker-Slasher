###
# Class for a stat belonging to a character.
###
class_name Stat

## Base value before any calculations
var base_value: float = 0

## The things that will change the modified value
var modifiers: Array[StatModifier] = []

## Should this stat be returned as an int?
var return_as_int: bool = false

## Initialize the stat.
func _init(init_value: float, is_int: bool):
	base_value    = init_value
	return_as_int = is_int

## Raise the base value by the passed amount. Usually called when leveling up.
func raise_base_value_by(raise_amount: float) -> void:
	base_value += raise_amount
	
## For when you want to get the unmodified value, for whatever reason.
func get_base_value() -> float:
	return base_value

## Set the base value directly.
func set_base_value(value_to_set: float) -> void:
	base_value = value_to_set

## Add the passed modifier.
func add_modifier(modifier_to_add: StatModifier):
	modifiers.append( modifier_to_add )
	modifiers.sort_custom(sort_ascending)

## Remove the passed modifier, if it exists within the stored modifiers.
func remove_modifier(modifier_to_remove: StatModifier) -> void:
	modifiers.erase( modifier_to_remove )

func sort_ascending(mod_a, mod_b):
	if mod_a.sort_order < mod_b.sort_order:
		return true
	return false

## Returns the modifiers, if any.
func get_modifiers() -> Array[StatModifier]:
	return modifiers

## Get the calculated value for this stat.
func get_calculated_value() -> float:
	var final_value = base_value
	for i in range( modifiers.size() ):
		var mod = (modifiers[i] as StatModifier)
		if mod.stat_modifier_type == StatModifierTypes.stat_modifier_types.Flat:
			final_value += mod.get_value()
		elif mod.stat_modifier_type == StatModifierTypes.stat_modifier_types.Percent:
			final_value *= ( 1 + mod.get_value() )
	return final_value
