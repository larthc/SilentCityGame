extends Node2D
class_name NPC

@export var npc_id: String = "marcos" # marcos, saqueador, goblin, nox
@export var phase: int = 1

func interact():
	print("Interagindo com NPC:", npc_id, "na fase:", phase)