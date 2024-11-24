@tool
## Allows a weapon to "exist" in the game world.
class_name Weapon extends Node3D

## Cached to allow some conveniences.
@export var weapon_data: WeaponData:
	set(value):
		weapon_data = value

## The location where projectiles should come out of this weapon.
@export var fire_point: Node3D

@export var fire_cast: RayCast3D

var curr_ammo:     int = 0:
	get: return curr_ammo
	set(value):
		curr_ammo = value
		curr_ammo = clamp(curr_ammo, 0, weapon_data.max_ammo)

var _curr_cooldown: float = 0.0

func _ready() -> void:
	curr_ammo = weapon_data.max_ammo

func tick(delta: float) -> void:
	_curr_cooldown += delta

## Get the position of where projectiles should release from a weapon.
func get_fire_point() -> Node3D:
	return fire_point

func reset_attack_cooldown() -> void:
	_curr_cooldown = 0

func is_cooldown_finished() -> bool:
	return _curr_cooldown > weapon_data.action_rate

func attack(aim_dir: Vector3) -> void:
	pass
