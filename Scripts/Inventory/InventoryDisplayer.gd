## Handles displaying an inventory.
class_name InventoryDisplayer extends Control

## The inventory being displayed.
@export var inventory_to_display: Inventory

## Template of the item slot.
@export var item_slot_prefab: PackedScene

## The container that will house the items.
@export var grid_container: GridContainer

func set_inventory_to_display(new_inventory: Inventory) -> void:
	inventory_to_display = new_inventory
	inventory_to_display.inventory_updated.connect( populate_item_grid )
	populate_item_grid( inventory_to_display )

func clear_inventory() -> void:
	inventory_to_display.inventory_updated.disconnect( populate_item_grid )
	inventory_to_display = null

## Populate the items that should be displayed.
## If this is called due to a signal, this simply updates the display.
func populate_item_grid(inventory_data: Inventory) -> void:
	# First clear any slots currently being displayed
	for c in grid_container.get_children():
		grid_container.remove_child( c )
		c.queue_free()
	
	# Create the slots
	for slot_data in inventory_data.stored_items:
		var slot: ItemSlotUI = item_slot_prefab.instantiate()
		grid_container.add_child(slot)
		
		# Subscribe to any relevant events
		# Tell our monitored inventory to connect to the slot clicked events
		slot.slot_clicked.connect( inventory_to_display.on_slot_clicked )
		
		# If the current slot has something to show
		if slot_data != null:
			slot.set_slot_data(slot_data)
