## A class that stores variables related to different types of stats.
class_name StatTypes

enum stat_types {
	# Attributes
	Vitality,             ## For health, defense, etc.
	Expertise,            ## For physical/regular damage, etc.
	Will,                 ## For mind, special points, etc.
	
	# Vitals
	MaxHP,                # Max hit points
	CurrentHP,            # Current hit points
	MaxSP,                # Our max mana/stamina/etc.
	CurrentSP,            # Our current mana/stamina/etc.
	
	# Other stats
	Perception,           # (Hit chance) = Expertise + Will and bonuses
	Evasion,              # (Dodge)      = Vitality  + Expertise and bonuses
	Speed,                # (Vitality + Will and bonuses) / 2
	CriticalHitChance,
	PhysicalPower,
	SpecialPower,
	
	# Resistances (Damage Type)
	# Except for regular damage, the rest are primarily percentage based (0.0-1.0)
	Defense,
	HeatRes,
	ColdRes,
	ElectricityRes,
	PsychicRes,
	
	# Resistances (Status Effects)
	# Percentage based (0.0-1.0)
	Plagued
}

## The different types of damage.
enum DamageTypes {
	Base,
	Heat,
	Cold,
	Electricity,
	Psychic,
	True ## Ignores resistance.
}

## Easy accessor for returning the resistance for damage types.
static var damage_to_res_map: Dictionary = {
	DamageTypes.Base: stat_types.Defense,
	DamageTypes.Heat: stat_types.HeatRes,
	DamageTypes.Cold: stat_types.ColdRes,
	DamageTypes.Electricity: stat_types.ElectricityRes,
	DamageTypes.Psychic: stat_types.PsychicRes
}
