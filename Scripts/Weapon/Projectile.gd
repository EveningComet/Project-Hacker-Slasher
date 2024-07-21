## An object that moves and can damage characters.
class_name Projectile extends CharacterBody3D

@export var move_speed: float = 25.0

## How long, in seconds, before this object should destroy itself?
@export var max_lifetime: float = 10.0
var curr_lifetime:        float = 0.0

## The object that shot this projectile. Used to prevent projectiles from hurting
## the activator.
var shooter: Node3D = null # TODO: System to prevent projectiles from damaging allies.

var direction: Vector3 = Vector3.ZERO

var damage: int = 0 # TODO: This will have to be overhauled to store damage data.

func _ready() -> void:
	set_as_top_level(true)

func _physics_process(delta: float) -> void:
	
	velocity = direction * delta * move_speed
	var collision = move_and_collide(velocity)
	if collision:
		var collider = collision.get_collider()
		if collider:
			print("Projectile :: %s collided with %s." % [name, collider.name])
			
			if collider.has_node("Combatant"):
				var com: Combatant = collider.get_node("Combatant")
				# TODO: Functionality for preventing this projectile from harming allies.
				com.take_damage(10)
			
			# Destroy the projectile
			queue_free()
	
	# Tick and delete when enough time has passed
	curr_lifetime += delta
	if curr_lifetime >= max_lifetime:
		queue_free()

func set_shooter(_shooter) -> void:
	shooter = _shooter
	add_collision_exception_with(shooter)

## The direction that this projectile should move towards.
func set_direction(_dir: Vector3) -> void:
	direction = _dir

## What to do when this projectile collides with something?
func on_hit() -> void:
	pass
