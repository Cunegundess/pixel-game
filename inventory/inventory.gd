extends Resource

class_name Inv

signal update

@export var slots: Array[InvSlot]

func insert(item: InvItem):
	var itemslots = slots.filter(func(slot): return slot.item == item)
	if !itemslots.is_empty():
		itemslots[0].amount += 1
	else:
		var emptyslot = slots.filter(func(slot): return slot.item == null)
		if !emptyslot.is_empty():
			emptyslot[0].item = item
			emptyslot[0].amount = 1
	
	update.emit()
