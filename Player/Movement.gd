extends KinematicBody2D

onready var collisionShape = $CollisionShape2D
onready var sprite = $Sprite

var velocity = Vector2.DOWN

enum {
		IDLE,
		COMBAT,
		MOVEMENT
	}

var state = IDLE


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_process(delta):
	match (state):
		IDLE:
			Idle(delta)
		
		COMBAT:
			Combat()
		
		MOVEMENT:
			Movement(delta)
		
func Idle(delta):
	var direction = Vector2.DOWN
	direction = Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"), Input.get_action_strength("down") - Input.get_action_strength("up"))
	#velocity = move_toward()

func Combat():
	pass

func Movement(delta):
	pass
