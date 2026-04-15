extends Node

signal item_added(item: InventoryItem)
signal item_removed(item: InventoryItem)
signal inventory_changed
signal memory_collected(item: InventoryItem)

const MAX_SLOTS: int = 20

var items: Array[InventoryItem] = []


func add_item(item: InventoryItem) -> bool:
	# Tenta empilhar se o item já existir no inventário
	for existing in items:
		if existing.id == item.id:
			existing.quantity += item.quantity
			emit_signal("item_added", existing)
			emit_signal("inventory_changed")
			return true

	# Verifica limite de slots antes de adicionar novo
	if items.size() >= MAX_SLOTS:
		return false

	var new_item := item.duplicate() as InventoryItem
	items.append(new_item)
	emit_signal("item_added", new_item)
	emit_signal("inventory_changed")
	return true


func remove_item(item: InventoryItem) -> void:
	items.erase(item)
	emit_signal("item_removed", item)
	emit_signal("inventory_changed")


func use_item(item: InventoryItem) -> void:
	match item.type:
		InventoryItem.ItemType.MEMORY:
			# Memórias não são consumidas ao "usar" — emite sinal para exibir conteúdo
			emit_signal("memory_collected", item)
		InventoryItem.ItemType.COMMON:
			# Itens comuns são consumidos ao usar
			item.quantity -= 1
			if item.quantity <= 0:
				remove_item(item)
			else:
				emit_signal("inventory_changed")


func has_item(id: String) -> bool:
	for item in items:
		if item.id == id:
			return true
	return false


func get_memories() -> Array[InventoryItem]:
	var memories: Array[InventoryItem] = []
	for item in items:
		if item.type == InventoryItem.ItemType.MEMORY:
			memories.append(item)
	return memories


func clear() -> void:
	items.clear()
	emit_signal("inventory_changed")
