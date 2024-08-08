## For skills that need to spawn a projectile.
class_name SpawnProjectileEffect extends SkillEffect

@export var num_to_spawn:      int = 1
@export var projectile_prefab: PackedScene

func execute(activator, targets) -> void:
	for i in num_to_spawn:
		var projectile: Projectile = projectile_prefab.instantiate()
		activator.get_tree().root.add_child(projectile)
	
		# TODO: Proper spawning of projectile location and handling of direction.
		# e.g: spawn at the fire point of a gun.
		var origin:     Vector3 = activator.global_position + Vector3.UP
		var aim_dir:    Vector3 = Vector3.ZERO
		var target_dir: Vector3 = Vector3.ZERO
		if activator.has_node("PlayerLocomotionController"):
			target_dir = activator.get_node("PlayerSkillHandler").get_aim_dir()
		
		aim_dir = (target_dir - origin).normalized()
		projectile.global_position = origin
		projectile.set_shooter(activator)
		projectile.set_direction(aim_dir)
		projectile.look_at(activator.global_transform.origin + aim_dir + Vector3.UP, Vector3.UP)
