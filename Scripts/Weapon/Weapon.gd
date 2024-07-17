@tool
## Allows a weapon to "exist" in the game world.
class_name Weapon extends Node3D

@export var weapon_data: WeaponData

## The location where projectiles should come out of this weapon.
@export var fire_point: Node3D

@export var fire_cast: RayCast3D

var curr_ammo: int = 0
var curr_cooldown: float = 0.0

func _ready() -> void:
	curr_ammo = weapon_data.max_ammo

func tick(delta: float) -> void:
	curr_cooldown += delta

## Get the position of where projectiles should release from a weapon.
func get_fire_point() -> Node3D:
	return fire_point

func reset_attack_cooldown() -> void:
	curr_cooldown = 0

func attack(aim_dir: Vector3) -> void:
	pass
