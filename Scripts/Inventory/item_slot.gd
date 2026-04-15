extends Panel

signal slot_selected(item: InventoryItem)

# Cor de destaque para Memórias
const COLOR_MEMORY := Color(1.0, 0.85, 0.2, 1.0)   # dourado
const COLOR_COMMON := Color(0.7, 0.7, 0.7, 1.0)     # cinza

var item: InventoryItem = null

@onready var icon_rect: TextureRect = $MarginContainer/Icon
@onready var quantity_label: Label = $QuantityLabel
@onready var highlight_rect: ColorRect = $Highlight


func set_item(new_item: InventoryItem) -> void:
	item = new_item

	if item == null:
		icon_rect.texture = null
		quantity_label.visible = false
		highlight_rect.visible = false
		return

	icon_rect.texture = item.icon
	quantity_label.text = "x%d" % item.quantity
	quantity_label.visible = item.quantity > 1

	# Cor da borda conforme o tipo
	if item.type == InventoryItem.ItemType.MEMORY:
		add_theme_stylebox_override("panel", _make_border_style(COLOR_MEMORY))
	else:
		add_theme_stylebox_override("panel", _make_border_style(COLOR_COMMON))


func set_selected(selected: bool) -> void:
	highlight_rect.visible = selected


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if item != null:
			emit_signal("slot_selected", item)


func _make_border_style(color: Color) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = Color(0.15, 0.15, 0.15, 0.9)
	style.border_color = color
	style.set_border_width_all(2)
	style.set_corner_radius_all(4)
	return style
