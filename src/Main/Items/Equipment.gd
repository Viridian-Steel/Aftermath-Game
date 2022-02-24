#Base class for all equipable Items
extends Item

class_name Equipment


enum Slot { Weapon, Accessory }

export (Slot) var slot = Slot.Weapon

# stat boosts provided when equipped
export (Dictionary) var stats = {
	"Defense" 	: 0,
	"Speed" 	: 0,
	"Attack"	: 0
} setget , _get_stats


func _get_stats() -> CharacterStats:
	# TODO figure out a way to stack these stats onto battlers,
	# will probably require creating a new stats class for equipment
	return stats

