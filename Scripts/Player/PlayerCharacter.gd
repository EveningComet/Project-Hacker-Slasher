## Used as a convenient way to access various nodes of a player.
## The "middle-man" between other parts of the game and things the player has.
class_name PlayerCharacter extends CharacterBody3D

@export var input_controller: PlayerInputController

## Reference to the player's inventory.
@export var player_inventory: Inventory

@export var player_equipment: PlayerEquipmentInventory

@export var player_weapon_controller: PlayerWeaponController

## Reference to the component that keeps track of the player's stats.
@export var combatant: Combatant

@export var skill_handler: SkillHandler

@export var player_inventory_handler: PlayerInventoryHandler

func _ready() -> void:
	input_controller.player_character = self
	initialize_inventory()

func initialize_inventory() -> void:
	# Setup the inventory and equipment
	player_equipment.set_stats(combatant.stats)
	
	# Test adding an item
	var item: ItemData = preload("res://Game Data/Items/Test Item.tres")
	var slot_data = ItemSlotData.new()
	slot_data.stored_item = item
	slot_data.quantity    = 1
	player_inventory.add_slot_data(slot_data)
	
	player_inventory_handler.setup(
		input_controller,
		player_inventory,
		player_equipment
	)

func is_inventory_open() -> bool:
	return player_inventory_handler.visible == true
