## Displays an item in an inventory.
class_name ItemSlotUI extends PanelContainer

signal slot_clicked(index: int, button: int)

## The visual that will be displayed.
@export var icon: TextureRect

## Displays the quantity of the item, if able.
@export var amount_label: Label

func _ready() -> void:
	gui_input.connect( on_gui_input )

func set_slot_data(slot_data: ItemSlotData) -> void:
	var item: ItemData = slot_data.stored_item
	
	if slot_data.stored_item != null:
		icon.set_texture( item.item_icon )
	
	if slot_data.quantity > 1:
		amount_label.set_text( str(slot_data.quantity) )
		amount_label.show()
	else:
		amount_label.set_text( str(1) )
		amount_label.hide()

func on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
		and (event.button_index == MOUSE_BUTTON_LEFT \
		or event.button_index == MOUSE_BUTTON_RIGHT) \
		and event.is_pressed():
			slot_clicked.emit(get_index(), event.button_index) 
