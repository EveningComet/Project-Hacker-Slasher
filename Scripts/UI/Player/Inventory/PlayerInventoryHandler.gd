## The middleman for a player's inventory and equipment.
class_name PlayerInventoryHandler extends CanvasLayer

@export var player_inventory: Inventory = null
@export var player_equipment: PlayerEquipmentInventory = null

@export_category("UI Components")
@export var inventory_displayer: InventoryDisplayer
@export var equipment_displayer: InventoryDisplayer

## Mainly used to see if the player pressed the inventory button.
var input_controller: PlayerInputController

func _ready() -> void:
	close()

func setup(
	_input_controller: PlayerInputController,
	new_player_inventory: Inventory,
	new_player_equipment: PlayerEquipmentInventory
	) -> void:
	input_controller = _input_controller
	input_controller.toggle_inventory.connect( on_inventory_toggled )
	set_player_inventory(new_player_inventory)

func set_player_inventory(new_inventory: Inventory) -> void:
	player_inventory = new_inventory
	player_inventory.inventory_interacted.connect( on_inventory_interacted )
	inventory_displayer.set_inventory_to_display(player_inventory)

func set_player_equipment(new_player_equipment: PlayerEquipmentInventory) -> void:
	player_equipment = new_player_equipment
	player_equipment.inventory_interacted.connect( on_inventory_interacted )
	equipment_displayer.set_inventory_to_display(player_equipment)

## Fired whenever the player interacts with a particular inventory.
func on_inventory_interacted(inventory_data: Inventory, slot_data: ItemSlotData) -> void:
	pass

func open() -> void:
	show()

func close() -> void:
	hide()

func on_inventory_toggled() -> void:
	if visible == true:
		close()
	else:
		open()
