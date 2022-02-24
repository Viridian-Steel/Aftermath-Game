#Container for the Sqaud
#H
#
extends Node2D
class_name Party

export var PARTY_SIZE: int = 3

var inventory = Inventory.new()


func get_active_members():
    # Returns the first unlocked children until the party is filled
    var active = []
    var available = get_unlocked_characters()
    for i in range(min(len(available), PARTY_SIZE)):
        active.append(available[i])
    return active


func get_unlocked_characters() -> Array:
    # Returns all the characters that can be active in the party
    var has_unlocked = []
    for member in get_children():
        if member.visible:
            has_unlocked.append(member)
    return has_unlocked
