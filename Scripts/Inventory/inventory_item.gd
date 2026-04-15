class_name InventoryItem
extends Resource

enum ItemType {
	COMMON,
	MEMORY
}

@export var id: String = ""
@export var display_name: String = ""
@export var description: String = ""
@export var icon: Texture2D = null
@export var type: ItemType = ItemType.COMMON
@export var quantity: int = 1
