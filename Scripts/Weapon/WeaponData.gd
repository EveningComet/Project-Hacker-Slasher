## Stores information for items related to weapons.
class_name WeaponData extends ItemData

@export_category("General Weapon Info")
## How often the player can attack with this weapon, in seconds.
@export var action_rate: float = 0.5

## A copy of the weapon in the game.
@export var weapon_prefab: PackedScene

@export_category("Firearm Related")
@export var max_ammo: int = 120
