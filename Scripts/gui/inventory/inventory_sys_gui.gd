class_name InventorySystemUI
extends Control

@export var inventory_handler : InventoryHandler

@onready var loot_inventory_ui : InventoryUI = get_node(NodePath("LootInventoryUI"))

@onready var transaction_slot_ui : TransactionSlotUI = $TransactionSlotUI

func _ready():
	loot_inventory_ui.slot_point_down.connect(_slot_point_down)
	loot_inventory_ui.set_inventory(inventory_handler.get_inventory(0))

func _slot_point_down(_event : InputEvent, slot_index : int, inventory : Inventory):
	if inventory_handler.is_transaction_active():
		inventory_handler.transaction_to_at(slot_index, inventory, 1)
	else:
		if inventory.is_empty_slot(slot_index):
			return
		inventory_handler.to_transaction(slot_index, inventory, 1)

func _on_inventory_handler_updated_transaction_slot() -> void:
	transaction_slot_ui.update_info_with_item(inventory_handler.transaction_slot)
