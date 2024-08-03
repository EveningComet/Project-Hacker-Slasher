## Used as a convenient way to access various nodes of a player.
## The "middle-man" between other parts of the game and things the player has.
class_name PlayerCharacter extends CharacterBody3D

## Reference to the player's inventory.
@export var player_inventory: Inventory

@export var player_equipment: PlayerEquipmentInventory

@export var player_weapon_controller: PlayerWeaponController

## Reference to the component that keeps track of the player's stats.
@export var combatant: Combatant

@export var skill_handler: SkillHandler

func _ready() -> void:
	player_inventory.initialize_slots()
