## Responsible for healing characters in range.
class_name HealingAura extends Area3D
# TODO: Create a more generic stat changing aura class instead?

@export var heals_enemies: bool = false

## In seconds, this how long before the healing will be performed.
@export var heal_rate: float = 1.0

## How long, in seconds, this is allowed to live.
@export var max_lifetime: float = 10.0
var curr_lifetime: float = 0.0

var healing_power: int = 5
var targets: Array = []

func _ready() -> void:
	body_entered.connect( on_body_entered )
	body_exited.connect(  on_body_exited  )

func _physics_process(delta: float) -> void:
	curr_lifetime += delta

func on_rate_reached() -> void:
	for t in targets:
		var combatant: Combatant = t.get_node("Combatant")
		combatant.stats.heal(healing_power)

func on_body_entered(body) -> void:
	if body.has_node("Combatant"):
		targets.append(body)

func on_body_exited(body) -> void:
	if body.has_node("Combatant"):
		targets.erase(body)
