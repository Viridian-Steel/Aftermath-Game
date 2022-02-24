"""
Player-controlled pawn.
Set to Stop during pause
"""
extends PawnActor

class_name PawnLeader
# Array of contiguous points to move to in game_board coordinates, provided by the game_board's pathfinder
var _path_current : = PoolVector3Array() 

func _ready() -> void:
	pass

func _process(delta):
	var direction : = Vector2()
	var key_input_direction = Vector2(
		int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	).normalized()

	if direction == Vector2():
		return
	# Movement
	update_look_direction(direction)
	var target_position = game_board.request_move(self, direction)
	if target_position:
		move_to(target_position)
	else:
		bump()
