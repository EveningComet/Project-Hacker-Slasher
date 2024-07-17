## Stores information for items related to weapons.
class_name WeaponData extends ItemData

@export_category("General Weapon Info")
## How often the player can attack with this weapon, in seconds.
@export var action_rate: float = 0.5

## A copy of the weapon's graphics.
@export var weapon_prefab: PackedScene

@export_category("Firearm Related")
@export var max_ammo:     int = 120

## How many shots can be taken before the gun must be reloaded?
@export var ammo_per_mag: int = 30

## How many shots does this projectile fire at once?
@export var num_shots: int = 1

## Prefab of a bullet for this weapon.
@export var bullet_hole: PackedScene

# The random recoil in the x and y directions
@export var x_range: float = 1.0
@export var y_range: float = 1.0

## Does this weapon fire real projectiles or does it just use raycasts?
@export var uses_real_projectiles: bool = false
## Copy of the projectile that this weapon will fire, if it uses real projectiles.
@export var projectile_prefab: PackedScene

