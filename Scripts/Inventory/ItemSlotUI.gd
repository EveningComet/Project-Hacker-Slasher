## Displays an item in an inventory.
class_name ItemSlotUI extends Button

## The item visual that will be displayed.
@export var display_icon: TextureRect

## Displays the quantity of the item, if able.
@export var amount_label: Label

## The item slot currently being stored.
var item_slot: ItemSlotData = null

func set_slot_data(slot_data: ItemSlotData) -> void:
	item_slot = slot_data
	
	if item_slot.stored_item != null:
		display_icon.set_texture( item_slot.stored_item.item_icon )
	
	if item_slot.quantity > 1:
		amount_label.set_text( str(item_slot.quantity) )
		amount_label.show()
	else:
		amount_label.set_text( str(1) )
		amount_label.hide()
