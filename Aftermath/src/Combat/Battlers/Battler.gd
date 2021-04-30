extends Position2D

class_name Battler

signal died(Battler)

export var TARGET_OFFSET_DISTANCE: float = 120.0

export var stats: Resource
onready var drops := $Drops
onready var actions = $Actions
onready var bars = $Bars
onready var skills = $Skills
onready var ai = $AI
onready var skin = $Skin


var target_global_postion: Vector2
var selected: bool = false setget set_selected
var selectable: bool = false setget set_selectable
var display_name: String

export var party_member = false
export var turn_order_icon: Texture

func _ready() -> void:
    var direction : Vector2  = Vector2(-1.0, 0.0) if party_member else Vector2(1.0, 0.0)
    target_global_postion = $TargetAnchor.global_posiion + direction * TARGET_OFFSET_DISTANCE
    selectable = true
    
func initialize():
    skin.initialize()
    actions.initialize(skills.get_children())
    stats = stats.copy()
# warning-ignore:return_value_discarded
    stats.connect("health_depleted", self, "on_health_depleted")
    

func is_able_to_play() -> bool:
    # Returns true if the battler can perform an action
    return stats.health > 0
    
func _on_health_depleted():
    selectable = false
    yield(skin.play_death(), "completed")
    emit_signal("died", self)

func set_selected(value):
    selected = value
    

func set_selectable(value):
    selectable = value
    if not selectable:
        set_selected(false)

func take_damage(hit):
    stats.take_damage(hit)
    # prevent playing both stagger and death animation if health <= 0
    if stats.health > 0:
        skin.play_stagger()

func appear():
    var offset_direction = 1.0 if party_member else -1.0
    skin.position.x += TARGET_OFFSET_DISTANCE * offset_direction
    skin.appear()

func has_point(point : Vector2):
    return skin.battler_anin.extents.has_point(point)
    
